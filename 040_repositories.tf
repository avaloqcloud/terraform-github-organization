data "github_repositories" "repositories" {
  query           = "org:${var.organization_slug}"
  include_repo_id = true
}

resource "github_repository" "all" {
  for_each = var.repositories

  name        = each.key
  description = each.value.description
  #homepage_url
  visibility = each.value.visibility
  has_issues = true
  #has_discussions
  has_projects = true
  has_wiki     = true
  is_template  = each.value.is_template
  #allow_merge_commit
  #allow_squash_merge
  #allow_rebase_merge
  #allow_auto_merge
  #squash_merge_commit_title
  #squash_merge_commit_message
  #merge_commit_title
  #merge_commit_message
  delete_branch_on_merge = false
  auto_init              = false
  has_downloads          = true
  #auto_init
  gitignore_template = each.value.gitignore_template
  license_template   = "apache-2.0"
  #archived
  #archive_on_destroy
  #pages
  #security_and_analysis
  topics = each.value.topics
  #template
  #vulnerability_alerts
  #ignore_vulnerability_alerts_during_read
  #allow_update_branch
}

resource "github_repository_collaborators" "all" {
  for_each = local.repositories_collaborators

  repository = each.key
  dynamic "user" {
    for_each = each.value.users
    content {
      username   = user.value["username"]
      permission = user.value["permission"]
    }
  }
  dynamic "team" {
    for_each = each.value.teams
    content {
      team_id    = team.value["team"]
      permission = team.value["permission"]
    }
  }
}
