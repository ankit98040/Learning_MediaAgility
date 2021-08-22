terraform {
	backend "s3" {
		region = "us-east-1"
		key = "name_of_state_file" #name of the state file
		bucket = "bucket_name"
	}
}