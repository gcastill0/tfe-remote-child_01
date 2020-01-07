data "terraform_remote_state" "rstate" {
  backend = "remote"
  config = {
    workspaces {
      hostname = "${TFE_HOST}"
      organization = "${TFE_ORG}"
      token = "${TFE_TOKEN}"
      name = "tfe-remote-parent"
    }
  }
}
