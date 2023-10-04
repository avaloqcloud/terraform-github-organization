# Validate provided GitHub users on `terraform plan`
data "github_user" "user" {
  for_each = var.catch_non_existing_users ? var.users : {}

  username = each.key
}

resource "github_organization_block" "blocked_user" {
  for_each = {
    for user, cfg in var.users : user => cfg
    if cfg.blocked
  }

  username = each.key
}

resource "github_membership" "all" {
  for_each = {
    for user, cfg in var.users : user => {
      username = cfg.username,
      role     = cfg.role
    } if !cfg.blocked
  }

  username = each.value.username
  role     = each.value.role
}
