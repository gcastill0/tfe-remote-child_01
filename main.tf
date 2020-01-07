data "terraform_remote_state" "rstate" {
  backend = "remote"
  config = {
    hostname     = "${TFE_HOST}"
    organization = "${TFE_ORG}"
    token        = "${TFE_TOKEN}"
    workspaces = {
      name = "tfe-remote-parent"
    }
  }
}
