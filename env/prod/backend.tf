terraform{
    backend "s3" {
        bucket="backend-e0cc4b2ea227f042"
        key="prod/terraform.tfstate"
        region="ap-south-1"
    }
}
