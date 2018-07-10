# prov_aws_infra_ship
Terraform Scripts for AWS Infra to run one-box pilot Shippable Server.

Use without_vpc if you already have an existing VPC and just want to provision machines and ELBs in it.

Use with_vpc if you want to provision a new VPC and then provision the infrastrucure needed for Shippable Server inside that VPC.
