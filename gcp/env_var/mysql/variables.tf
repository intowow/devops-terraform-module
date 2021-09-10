variable "host" {
  description = "Host"
  type        = string
  default     = null
}

variable "port" {
  description = "Port"
  type        = number
  default     = null
}

variable "socket_path" {
  description = "Socket path"
  type        = string
  default     = null
}

variable "secret_id" {
  description = "The secret which contains mysql username/password"
  type        = string
}

variable "database" {
  description = "Database name"
  type        = string
}
