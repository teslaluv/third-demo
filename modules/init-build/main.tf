resource "null_resource" "build" {
  provisioner "local-exec" {
    command = "make build"
    working_dir = "/home/teslaluv/demo3/project/app"
    environment = {
        TAG = var.image_tag
        REGISTRY_ID = var.reg_id
        REPOSITORY_REGION = var.region
        APP_NAME = var.app_name
    }
  }
}
