#to be saved with extension .tfvars

#base types -> bool, string , number

variable "my-var" {
	type = string
	default = "hello"
	validation {
		condition = length(var.my-var) > 4
		error_message = "length must be 4 chars"
	}
}