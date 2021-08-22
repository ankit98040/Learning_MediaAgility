module "my-vpc-module" {
	source = "./modules/vpc"
	version = "0.0.5"
	region = var.region
}