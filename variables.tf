variable "ami" {
  type        = string
  default     = "ami-06885bf4009501fc0" # Fuck CentOS it was deprecated in 2021, using Debian 12 ami now
  description = "AMI code for the Airflow server"
}

variable "instance_type" {
  type        = string
  default     = "c3.xlarge"
  description = "Instance type for the Airflow server"
}

variable "key" {
  type        = string
  description = "AWS SSH Key Pair name"
}

variable "subnet_ids" {
  type        = list
  description = "List of AWS subnet ids for Airflow server and database"
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC in which to create the Airflow server"
}

variable "security_group_id" {
  type        = string
  description = "AWS Security group in which to create the Airflow server"
}

variable "db_password" {
  type        = string
  description = "Password for the PostgreSQL instance"
}

variable "fernet_key" {
  type        = string
  description = "Key for encrypting data in the database - see Airflow docs"
}


variable "security_group_one" {
  type    = string
  default = "default_value" # You can set a default value if needed
}

variable "security_group_three" {
  type    = string
  default = "default_value"
}

variable "security_group_two" {
  type    = string
  default = "default_value"
}

