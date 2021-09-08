data "google_organization" "org" {
  domain = "example.com"
}

resource "google_folder" "sales" {
  display_name = "Sales"
  parent       = data.google_organization.org.name
}

#another way to pass organization
resource "google_folder" "department-1" {
  display_name = "department-1"
  parent       = "organizations/1234567"
}

# Folder nested under another folder.
resource "google_folder" "team-abc" {
  display_name = "Team ABC"
  parent       = google_folder.department1.name
}



resource "google_project" "my-project-in-a-folder" {
  name 	      = "my-project"
  project_id = "your-project-id"
  folder_id  = "${google_folder.department-1.name}"
}


##with org id and billing account
resource "google_project" "project" {
  name            = var.project_name
  project_id      = random_id.id.hex
  billing_account = var.billing_account
  org_id          = var.org_id
}



