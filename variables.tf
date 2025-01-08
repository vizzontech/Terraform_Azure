variable "resource_group_name" {
  default = "vizzon-tf-2025"
}
variable "location" {
    default = "UKWest"
}
variable "sku_name" {
  type        = string
  description = "Enter SKU"
  default     = "S0"
}
variable "license_type" {
  type        = string
  description = "Enter license type"
  default     = "BasePrice"
}
variable "vcores" {
  type        = number
  description = "Enter number of vCores you want to deploy"
  default     = 8
}
variable "storage_size_in_gb" {
  type        = number
  description = "Enter storage size in GB"
  default     = 2
}



