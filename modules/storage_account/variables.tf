variable "blob_name" {
  description = "The name of the storage blob (e.g., index.html)"
  type        = string
}

variable "blob_source" {
  description = "The path to the source file to upload as a blob"
  type        = string
}

variable "blob_content_type" {
  description = "The content type of the blob (e.g., text/html)"
  type        = string
  default     = "application/octet-stream"
}