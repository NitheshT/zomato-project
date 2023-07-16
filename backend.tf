terraform {
backend "s3" {
bucket = "terrraform.git.project9090"
key = "terraform.tfstate"
}
}
