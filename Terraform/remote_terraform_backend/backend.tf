#backend for gcp storage

terraform {
  backend "gcs" {
    bucket  = "tf-state-prod98040"
    prefix  = "terraform/state"
  }
}


#backend for aws s3

#terraform {
#	backend "s3" {
#		profile = "default"
#		region = "us-east-1"
#		key = "terraform.tfstate" #name of the state file
#		bucket = "bucket_name"
#	}
#}