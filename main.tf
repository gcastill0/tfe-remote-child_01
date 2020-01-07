data "terraform_remote_state" "rstate" {
  backend = "remote"
  config = {
    workspaces = {
      name = "tfe-remote-parent"
    }
  }
}
