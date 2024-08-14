variable "tags" {
  description = "Tags to set on the bucket"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "The cloud execution environment"
  type        = string
}
