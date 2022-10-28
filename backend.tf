terraform {
    backend "s3" {
        bucket = "ta-terraform-tfstates-923372466541"
        key = "tf-lab/s3-training/terraform.tfstates"
        dynamodb_table = "terraform-lock"
    }
}