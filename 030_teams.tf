data "github_organization_teams" "all" {}

resource "github_team" "all" {
  for_each = var.teams

  name                      = each.key
  description               = each.value.description
  privacy                   = each.value.privacy
  create_default_maintainer = false
}

resource "github_team_membership" "members" {
  for_each = {
    for membership in local.teams_memberships : "${membership.team}:${membership.username}" => {
      slug     = membership.slug,
      username = membership.username,
      role     = membership.role
    } if !membership.blocked
  }

  team_id  = each.value.slug
  username = each.value.username
  role     = each.value.role
}
