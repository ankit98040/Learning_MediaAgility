terraform {
	backend "s3" {
		profile = "default"
		region = "us-east-1"
		key = "terraform.tfstate" #name of the state file
		bucket = "bucket_name"
	}
}