variable "atlas_public_key" {
  type        = string
  description = "Mongodb Atlas Public Key"
  default     = ""
}

variable "atlas_private_key" {
  type        = string
  description = "Mongodb Atlas Private Key"
  default     = ""
}

# Atlas Organization ID
variable "atlas_org_id" {
  type        = string
  description = "Atlas Organization ID"
  default     = ""
}

# Atlas Project Name
variable "atlas_project_name" {
  type        = string
  description = "Atlas Project Name"
  default     = "FiapFood"
}

# Atlas Project Name
variable "atlas_cluster_name" {
  type        = string
  description = "Atlas Cluster Name"
  default     = "FiapFood"
}
