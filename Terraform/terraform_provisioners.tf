#provisioners help us to run specific files/scripts when our infrastructure is up

#provisioners are not tracked on the tfstate file

#there are two types of provisioners 1. create time, 2. destroy time

resource "null_resource" "provisioner-1" {
	provisioner "local-exec" {
		command = "echo '0' > status.txt "
	}

	provisioner "local-exec" {
		when = destroy
		command = "echo '0' > status.txt "
	}
}