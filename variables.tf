#vpc variables

variable "vpc_name" {
  description = "vpc name"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for creating the VPC"
  type        = string
}

variable "assign_generated_ipv6_cidr_block" {
  description = "if it true ipv6 cidr block created"
  type        = bool
}

variable "dns_hostnames_enabled" {
  description = "This variable is to enable/disable dns hostnames in VPC"
  type        = bool
}
variable "dns_support_enabled" {
  description = "This variable is to enable/disable dns support in VPC"
  type        = bool

}
variable "default_security_group_deny_all" {
  description = "This variable is to enable the default security with custom rules in the VPC"
  type        = bool
}

variable "availability_zones" {
  description = "This are the availability zones that we are creating the subnets and our aws resources are running"
}

variable "nat_gateways_count" {
  description = "This variable is to restrict the creation of NAT gateways and override the default behaviour of VPC module which will create NAT gateways as per the AZ count"
}

variable "single_nat" {
  type        = bool
  description = "If set to 'true' a single nat g/w will be created for multiple subnets and the variable 'nat_gateways_count' will be ignored"
}

variable "create_default_security_group" {
  default     = true
  description = "This variable will enable the default security group in the VPC module"
}

variable "assign_eip_address" {
  default     = true
  description = "This variable is to disable or enable eip creation for the bastion/ec2"
}

variable "associate_public_ip_address" {
  default     = true
  description = "Variable to enable public ip address for the bastion/ec2"
}

#keypair variables

variable "aws_key_pair_name" {
  type = string
}

variable "ssh_public_key_path" {
  type        = string
  description = "This is the local host path where the bastion public and private keys are stored once created"
}

variable "generate_ssh_key" {
  type        = bool
  description = "This variable generate SSH key for the ec2 instance module"
}

# baston host variables

variable "bastion_ami" {
  type        = string
  description = "The AMI to use for the instance/bastion. By default it is the AMI provided by Amazon with Ubuntu 22.04 LTS"
}

variable "bastion_instance_type" {
  type        = string
  description = "The instance type of the ec2/bastion"
}


variable "bastion_monitoring" {
  type        = bool
  description = "Enable/disable detailed Monitoring for the ec2/bastion instance"
}

variable "bastion_name" {
  default = "bastion_host"

}
variable "user_data_template" {
  type        = string
  description = "User Data template to use for provisioning EC2 Bastion Host"
}
variable "bastion_create_default_security_group" {
  type        = bool
  description = "Create default Security Group with only Egress traffic allowed"
  default     = true
}
variable "allowed_ports" {
  type        = list(number)
  description = "List of allowed ingress TCP ports"
  default     = []
}
variable "allowed_ports_udp" {
  type        = list(number)
  description = "List of allowed ingress UDP ports"
  default     = []
}
variable "ingress_cidr_blocks" {
  type    = list(string)
  default = []
}

#ecr variables

variable "enable_ecr" {
  description = "This variable will decide whether the elastic container registries are created or not for the environment"
  type        = bool
}

variable "enable_lifecycle_policy" {
  type        = bool
  description = "Set to false to prevent the module from adding any lifecycle policies to any repositories"
}

variable "ecr_repo_names" {
  type        = list(string)
  description = "List of Docker local image names, used as repository names for AWS ECR "
}

variable "image_tag_mutability" {
  type        = string
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`"
}


#eks variables

variable "region" {
  description = "AWS Region"
}

variable "kubernetes_version" {
  description = "Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided"
}

variable "eks_cluster_name" {
  description = "EKS prefix name given to create lable for the resources from label module "
}

variable "oidc_provider_enabled" {
  description = "Create an IAM OIDC identity provider for the cluster, then you can create IAM roles to associate with a service account in the cluster, instead of using kiam or kube2iam. For more information, see https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html"
}

variable "endpoint_private_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled. Default to AWS EKS resource and it is false"
}


#node group variables

variable "eks_nodegroup_instance_type" {
  description = <<-EOT
    Single instance type to use for this node group, passed as a list. Defaults to ["t2.medium"].
    It is a list because Launch Templates take a list, and it is a single type because EKS only supports a single type per node group.
    EOT
}

variable "desired_size" {
  description = "Initial desired number of worker nodes (external changes ignored)"
}

variable "min_size" {
  description = "Minimum number of worker nodes"
}

variable "max_size" {
  description = "Maximum number of worker nodes"
}

variable "capacity_type" {
  description = "instance capacity type"

}

variable "cluster_autoscaler_enabled" {
  description = "Set true to label the node group so that the [Kubernetes Cluster Autoscaler](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/README.md#auto-discovery-setup) will discover and autoscale it"
  type        = bool
}


######jenkins server variables################

variable "ec2_name" {
  type        = string
  description = "ec2_instance name"
}

variable "ec2_instance_type" {
  type        = string
  description = "ec2 instance type by default it is t2.micro"
  default     = "t2.micro"
}

variable "ec2_ami" {
  type        = string
  description = "the ami used for the instance"
}
variable "ami_owner" {
  type        = string
  description = "Owner of the given AMI (ignored if `ami` unset, required if set)"
}

variable "ec2_create_default_security_group" {
  type        = bool
  description = "Create default Security Group with only Egress traffic allowed"
  default     = true
}
variable "ec2_allowed_ports" {
  type        = list(number)
  description = "List of allowed ingress TCP ports"
  default     = []
}
variable "ec2_allowed_ports_udp" {
  type        = list(number)
  description = "List of allowed ingress UDP ports"
  default     = []
}

variable "ec2_user_data_template" {
  type        = string
  description = "User Data template to use for provisioning EC2 Bastion Host"
}

##################sonarqube variables#####################

variable "sonarqube_name" {
  type        = string
  description = "ec2_instance name"
}

variable "sonarqube_instance_type" {
  type        = string
  description = "ec2 instance type by default it is t2.micro"
  default     = "t2.micro"
}

variable "sonarqube_ami" {
  type        = string
  description = "the ami used for the instance"
}
variable "sonarqube_ami_owner" {
  type        = string
  description = "Owner of the given AMI (ignored if `ami` unset, required if set)"
}

variable "sonarqube_create_default_security_group" {
  type        = bool
  description = "Create default Security Group with only Egress traffic allowed"
  default     = true
}
variable "sonarqube_allowed_ports" {
  type        = list(number)
  description = "List of allowed ingress TCP ports"
  default     = []
}
variable "sonarqube_allowed_ports_udp" {
  type        = list(number)
  description = "List of allowed ingress UDP ports"
  default     = []
}

variable "sonarqube_user_data_template" {
  type        = string
  description = "User Data template to use for provisioning EC2 Bastion Host"
}
variable "sonarqube_ingress_cidr_blocks" {
  type    = list(string)
  default = []
}