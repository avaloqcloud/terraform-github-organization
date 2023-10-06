# Terraform GitHub Organization module

Terraform module wrapper around the [Terraform GitHub provider](https://www.terraform.io/docs/providers/github/index.html) to manage GitHub organization, users and repositories.

## Table of contents

* [Requirements](#requirements)
* [Inputs](#inputs)
* [Outputs](#outputs)
* [Usage](#usage)
  * [Importing existing resources](#importing-existing-resources)
    * [Organization](#organization)
    * [Teams](#teams)
    * [Repositories](#repositories)
* [External Documentation](#external-documentation)

## Requirements

* [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.2
* [Terraform module 'integrations/github'](https://registry.terraform.io/providers/integrations/github/latest/docs) >= 5.39

## Inputs

- [**`organization_slug`**](#var-organization_slug): *(**Required** `string`)*<a name="var-organization_slug"></a>  
  Organization's name as used in URLs and the API.
- [**`organization`**](#var-organization): *(**Required** `object()`)*<a name="var-organization"></a>  
  Object containing organization name and settings.  
  The `settings` object accepts the following attributes:
  - [**`name`**](#attr-settings-name): *(**Required** `string`)*<a name="attr-settings-name"></a>  
    Organization full name.
  - [**`admins`**](#attr-settings-admins): *(**Required** `list(string)`)*<a name="attr-settings-admins"></a>  
    List of admins of the organization.
  - [**`all_members_teams`**](#attr-settings-all_members_teams): *(**Required** `list(string)`)*<a name="attr-settings-all_members_teams"></a>  
    List of team names that will contain all organization members.
  - [**`settings`**](#attr-settings-settings): *(**Required** `map`)*<a name="attr-settings-settings"></a>  
    Refer to the Terraform GitHub provider [resource `github_organization_settings` documentation](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_settings).
- [**`users`**](#var-users): *(Optional `map()`)*<a name="var-users"></a>  
  Map of organization users and properties.
  - [**`username`**](#attr-users-username): *(**Required** `string`)*<a name="attr-users-username"></a>  
    GitHub username.
  - [**`name`**](#attr-users-name): *(Optional `string`)*<a name="attr-users-name"></a>  
    User firstname and lastname.
  - [**`role`**](#attr-users-role): *(Optional `string`, Default is `member`)*<a name="attr-users-role"></a>  
    User role in the organization (["admin", "member"]).
  - [**`teams`**](#attr-users-teams): *(Optional `list(string)`)*<a name="attr-users-teams"></a>  
    List of organization's team names user is member of.
  - [**`blocked`**](#attr-users-blocked): *(Optional `bool`, Default is `false`)*<a name="attr-users-blocked"></a>  
    Blocked flag.
- [**`catch_non_existing_users`**](#var-catch_non_existing_users): *(Optional `bool`, Default is `false`)*<a name="var-catch_non_existing_users"></a>  
  When true, validate provided GitHub users on `terraform plan`.
- [**`teams`**](#var-teams): *(Optional `map()`)*<a name="var-teams"></a>  
  Map of organization teams.
  - [**`name`**](#attr-teams-name): *(**Required** `string`)*<a name="attr-teams-name"></a>  
    Team name.
  - [**`description`**](#attr-teams-description): *(Optional `string`)*<a name="attr-teams-description"></a>  
    Team description.
  - [**`privacy`**](#attr-teams-privacy): *(Optional `string`, Default is `closed`)*<a name="attr-teams-privacy"></a>  
    Team privacy (["closed", "secret"]).
  - [**`maintainers`**](#attr-teams-maintainers): *(**Required** `list(string)`)*<a name="attr-teams-maintainers"></a>  
    List of maintainers' usernames.
- [**`repositories`**](#var-repositories): *(Optional `map(object)`)*<a name="var-repositories"></a>  
  Map of organization repositories.
  - [**`description`**](#attr-repositories-description): *(Optional `string`)*<a name="attr-repositories-description"></a>  
    Repository description.
  - [**`template`**](#attr-repositories-template): *(Optional `string`)*<a name="attr-repositories-template"></a>  
    Repository template.
  - [**`visibility`**](#attr-repositories-visibility): *(Optional `string`, Default is `public`)*<a name="attr-repositories-visibility"></a>  
    Repository privacy (["private", "public"]).
  - [**`has_discussions`**](#attr-repositories-has_discussions): *(Optional `bool`, Default is `false`)*<a name="attr-repositories-has_discussions"></a>  
    Enable GitHub repository discussions ([GitHub About discussions](https://docs.github.com/en/discussions)).
  - [**`has_issues`**](#attr-repositories-has_issues): *(Optional `bool`, Default is `false`)*<a name="attr-repositories-has_issues"></a>  
    Enable GitHub repository issues ([GitHub About issues](https://docs.github.com/en/issues/tracking-your-work-with-issues/about-issues)).
  - [**`has_projects`**](#attr-repositories-has_projects): *(Optional `bool`, Default is `false`)*<a name="attr-repositories-has_projects"></a>  
    Enable GitHub repository projects ([GitHub About projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/about-projects)).
  - [**`has_wiki`**](#attr-repositories-has_wiki): *(Optional `bool`, Default is `false`)*<a name="attr-repositories-has_wiki"></a>  
    Enable GitHub repository wiki ([GitHub About wiki](https://docs.github.com/en/communities/documenting-your-project-with-wikis/about-wikis)).
  - [**`is_template`**](#attr-repositories-is_template): *(Optional `bool`, Default is `false`)*<a name="attr-repositories-is_template"></a>  
    Flag repository as template.
  - [**`topics`**](#attr-repositories-topics): *(Optional `list(string)`)*<a name="attr-repositories-topics"></a>  
    List of topics.
  - [**`vulnerability_alerts`**](#attr-repositories-vulnerability_alerts): *(Optional `bool`, Default is `false`)*<a name="attr-repositories-vulnerability_alerts"></a>  
    Enable GitHub Dependabot alerts ([GitHub About Dependabot alerts](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/about-dependabot-alerts)).
  - [**`collaborators`**](#attr-repositories-collaborators): *(Optional `list(object)`)*<a name="attr-repositories-collaborators"></a>  
    List of collaborators (team and/or username) and corresponding permission.
  - [**`branch_protections`**](#attr-repositories-branch_protections): *(Optional `map(object)`)*<a name="attr-repositories-branch_protections"></a>  
    List of branch protections.
  - [**`gitignoreTemplate`**](#attr-repositories-gitignoreTemplate): *(Optional `string`)*<a name="attr-repositories-gitignoreTemplate"></a>  
    .gitignore template.
  - [**`files`**](#attr-repositories-files): *(Optional `map(object)`)*<a name="attr-repositories-files"></a>  
    List of files.

## Outputs

The following attributes are exported by the module:

- [**`organization_id`**](#output-organization_id): *(`string`)*<a name="output-organization_id"></a>  
  GitHub organization ID.
- [**`organization_settings`**](#output-organization_settings): *(`object`)*<a name="output-organization_settings"></a>  
  GitHub organization settings.
- [**`users`**](#output-users): *(`list(object)`)*<a name="output-users"></a>  
  A list of `user` resource objects that describe all members of the organization.
- [**`users_missing_iac`**](#output-users_missing_iac): *(`set(string)`)*<a name="output-users_missing_iac"></a>  
  List of users not being configured via the module.
- [**`organization_blocked_users`**](#output-organization_blocked_users): *(`set(string)`)*<a name="output-organization_blocked_users"></a>  
  A list of `github_organization_block` resource objects that describe all users that are blocked by the organization.
- [**`teams`**](#output-teams): *(`list(object)`)*<a name="output-teams"></a>  
  A list of `team` resource objects that describe all teams of the organization.
- [**`teams_missing_iac`**](#output-teams_missing_iac): *(`set(string)`)*<a name="output-teams_missing_iac"></a>  
  List of teams not being configured via the module.
- [**`team_membership`**](#output-team_membership): *(`set(string)`)*<a name="output-team_membership"></a>  
  Map of team members.
- [**`repositories_missing_iac`**](#output-repositories_missing_iac): *(`set(string)`)*<a name="output-repositories_missing_iac"></a>  
  List of repositories not being configured via the module.

## Usage

### File `versions.tf` content example:

```hcl
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.39"
    }
  }
}
```

### File `main.tf` content example:

```hcl
provider "github" {
  owner = local.github_organization_slug
}

module "github-organization" {
  source  = "github.com/avaloqcloud/terraform-github-organization"

  organization_slug        = local.github_organization_slug
  organization             = local.github_organization
  users                    = local.github_organization_users
  catch_non_existing_users = local.github_organization_catch_non_existing_users
  teams                    = local.github_organization_teams
  repositories             = local.github_organization_repositories
}

output "github_organization_id" {
  value = module.github-organization.organization_id
}
```

File `locals.tf` defining the variable values according to the [inputs definitions](#inputs).

### Importing existing resources

#### Organization

To import an existing organization, execute the following command:

```bash
terraform import module.<MODULE_NAME>.github_organization_settings.organization <ORGANIZATION_ID>
```
> **NOTE:** Replace `<MODULE_NAME>` and `<ORGANIZATION_ID>` with the module name (in the example code `github-organization`) and GitHub Organization ID returned by the `module.<MODULE_NAME>.organization_id` output value upon `terraform plan`.

#### Teams

To import an existing team, execute the following command:

```bash
$ terraform import 'module.<MODULE_NAME>.github_team.all["<TEAM_NAME>"]' <TEAM_SLUG>
```
> **NOTE:** Replace `<MODULE_NAME>` and `<TEAM_NAME>` with module name (in the example code `github-organization`) and the team name used by GitHub.

#### Repositories

To import an existing repository, execute the following command:

```bash
$ terraform import 'module.<MODULE_NAME>.github_repository.all["<REPOSITORY_SLUG>"]' <REPOSITORY_SLUG>
```
> **NOTE:** Replace `<MODULE_NAME>` and `<REPOSITORY_SLUG>` with module name (in the example code `github-organization`) and the repository slug used by GitHub.

## External Documentation

### Terraform GitHub Provider Documentation:

- https://www.terraform.io/docs/providers/github/index.html
