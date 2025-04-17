terraform {
    backend "s3" {
        bucket         = "tf-demo-terraform-state-teagan"
        key            = "state/infra-host.tfstate"
        region         = "us-east-1"
        dynamodb_table = "tf-demo-terraform-state-lock"
        encrypt        = false
    }
}