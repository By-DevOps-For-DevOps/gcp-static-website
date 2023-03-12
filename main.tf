provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

# Create new storage bucket in US multi-region
# with coldline storage and settings for main_page_suffic and not_found_page
resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "static_website" {
  name          = "${random_id.bucket_prefix.hex}-static-website-bucket"
  location      = "US"
  storage_class = "COLDLINE"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

# Upload a simple index.html page to the bucket
resource "google_storage_bucket_object" "index_page" {
  name         = "index.html"
  content      = "<html><body>Hello World!</body></html>"
  content_type = "text/html"
  bucket       = google_storage_bucket.static_website.id
}

# Upload a simple 404 / error page to the bucket
resource "google_storage_bucket_object" "error_page" {
  name         = "404.html"
  content      = "<html><body>404!</body></html>"
  content_type = "text/html"
  bucket       = google_storage_bucket.static_website.id
}

resource "google_storage_object_acl" "index_acl" {
  bucket      = google_storage_bucket.static_website.id
  object      = google_storage_bucket_object.index_page.name
  role_entity = ["READER:allUsers"]
}

resource "google_storage_object_acl" "not_found_acl" {
  bucket      = google_storage_bucket.static_website.id
  object      = google_storage_bucket_object.error_page.name
  role_entity = ["READER:allUsers"]
}
