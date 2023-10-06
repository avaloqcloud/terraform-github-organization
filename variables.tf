variable "organization_slug" {
  description = "Organization's name as used in URLs and the API"
  type        = string
}

variable "organization" {
  description = "Organization name and settings"
  type = object({
    name              = string
    admins            = list(string)
    all_members_teams = list(string)
    settings = object({
      description                                                  = string
      billing_email                                                = string
      company                                                      = string
      blog                                                         = string
      email                                                        = string
      twitter_username                                             = string
      location                                                     = string
      has_organization_projects                                    = bool
      has_repository_projects                                      = bool
      default_repository_permission                                = string
      members_can_create_repositories                              = bool
      members_can_create_public_repositories                       = bool
      members_can_create_private_repositories                      = bool
      members_can_create_internal_repositories                     = bool
      members_can_create_pages                                     = bool
      members_can_create_public_pages                              = bool
      members_can_create_private_pages                             = bool
      members_can_fork_private_repositories                        = bool
      web_commit_signoff_required                                  = bool
      advanced_security_enabled_for_new_repositories               = bool
      dependabot_alerts_enabled_for_new_repositories               = bool
      dependabot_security_updates_enabled_for_new_repositories     = bool
      dependency_graph_enabled_for_new_repositories                = bool
      secret_scanning_enabled_for_new_repositories                 = bool
      secret_scanning_push_protection_enabled_for_new_repositories = bool
    })
  })
}

variable "users" {
  description = "Organization users"
  type = map(object({
    username = string
    name     = string
    role     = string
    teams    = list(string)
    blocked  = bool
  }))
  default = {}
}

variable "catch_non_existing_users" {
  description = "Validate provided GitHub users on `terraform plan`"
  type        = bool
}

variable "teams" {
  description = "Organization teams"
  type = map(object({
    description      = string
    privacy          = string
    parent_team_slug = string
    all_members      = bool
    maintainers      = list(string)
  }))
  default = {}
}

variable "repositories" {
  description = "Organization repositories"
  type = map(object({
    description = string
    template = object({
      repository = string
    })
    visibility           = string
    has_discussions      = bool
    has_issues           = bool
    has_projects         = bool
    has_wiki             = bool
    is_template          = bool
    topics               = list(string)
    vulnerability_alerts = bool
    collaborators = list(object({
      team       = string
      username   = string
      permission = string
    }))
    branch_protections = map(object({}))
    gitignore_template = string
    files = map(object({
      content = string
    }))
  }))
  default = {}
}
