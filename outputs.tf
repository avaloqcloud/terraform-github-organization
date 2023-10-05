output "organization_id" {
  value       = data.github_organization.organization.id
  description = "GitHub organization ID"
}

output "organization_settings" {
  value       = github_organization_settings.organization
  description = "GitHub organization settings"
}

output "users" {
  description = "List of users"
  value       = data.github_organization.organization.users
}

output "users_missing_iac" {
  value       = local.users_missing_iac.*.login
  description = "List of users missing configuration"
}

output "organization_blocked_users" {
  description = "List of blocked users"
  value       = github_organization_block.blocked_user
}

output "teams" {
  description = "List of teams"
  value       = github_team.all
}

output "teams_missing_iac" {
  value       = local.teams_missing_iac.*.name
  description = "List of teams missing configuration"
}

output "team_membership" {
  description = "Map of team members"
  value       = github_team_membership.members
}

output "repositories_missing_iac" {
  value       = local.repositories_missing_iac.*
  description = "List of repositories missing configuration"
}
