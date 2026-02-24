region = "ap-south-1"
env    = "dev"

ami_id        = "ami-051a31ab2f4d498f5"
instance_type = "t3.micro"
key_name      = "jenkins"

my_ip = "183.87.208.64" #https://checkip.amazonaws.com/

db_name     = "appdb"
db_username = "admin"
db_password = "Admin1234"
vpc_cidr    = "10.0.0.0/16"

availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

nat_gateway_count = 1