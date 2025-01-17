resource "random_id" "example" {
  byte_length = 8
}
module "identity" {
  source = "../.."

  identity_name       = "id-${random_id.example.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location

  federated_identity_credentials = {
    # Allow authentication from environment "development"
    "github_env" = {
      name    = "github-env"
      issuer  = "https://token.actions.githubusercontent.com"
      subject = "repo:org/repo:environment:development"
    }

    # Allow authentication from branch "main"
    "github_branch" = {
      name    = "github-branch"
      issuer  = "https://token.actions.githubusercontent.com"
      subject = "repo:org/repo:ref:refs/heads/main"
    }

    # Allow authentication from pull request
    "github_pr" = {
      name    = "github-pr"
      issuer  = "https://token.actions.githubusercontent.com"
      subject = "repo:org/repo:pull_request"
    }

    # Allow authentication from tag "dev"
    "github_tag" = {
      name    = "github-tag"
      issuer  = "https://token.actions.githubusercontent.com"
      subject = "repo:org/repo:ref:refs/tags/dev"
    }
  }
}