locals {

  users_missing_iac = [
    for user in data.github_organization.organization.users : user
    if !contains(keys(var.users), user.login)
  ]

  teams_missing_iac = [
    for team in data.github_organization_teams.all.teams : team
    if !contains(keys(var.teams), team)
  ]

  # Evaluate all team-user relationships (including all_members team)
  teams_memberships = flatten([
    for username, user in var.users : concat([
      for team in user.teams : {
        username = username,
        blocked  = user.blocked,
        team     = team,
        slug     = github_team.all[team].slug,
        role     = contains(var.teams[team].maintainers, username) ? "maintainer" : "member"
      } if !var.teams[team].all_members
      ], [
      for all_members_team in var.organization.all_members_teams : {
        username = username,
        blocked  = user.blocked,
        team     = all_members_team,
        slug     = github_team.all[all_members_team].slug,
        role     = contains(var.teams[all_members_team].maintainers, username) ? "maintainer" : "member"
      }
    ])
  ])

  repositories_missing_iac = [
    for repository in data.github_repositories.repositories.names : repository
    if !contains(keys(var.repositories), repository)
  ]

  # Evaluate all repository-collaborators relationships
  repositories_collaborators = {
    for repository, configuration in var.repositories : repository => {
      users = [
        for collaborator in configuration.collaborators : {
          username   = collaborator.user,
          permission = collaborator.permission
        } if try(collaborator.user, "") != ""
      ],
      teams = [
        for collaborator in configuration.collaborators : {
          team       = try(github_team.all[collaborator.team].slug, null),
          permission = collaborator.permission
        } if try(collaborator.team, "") != ""
      ]
    }
  }
}
