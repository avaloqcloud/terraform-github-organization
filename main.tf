# Retrieve information about the currently (PAT) authenticated user
data "github_user" "self" {
  username = ""
}

data "github_organization" "organization" {
  name = var.organization_slug
}
