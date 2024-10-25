module "eks_blueprints" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.0.2"

  # EKS Cluster VPC and Subnet mandatory config
  vpc_id = "<vpc_id>"
  private_subnet_ids = "<private_subnet_ids>"

  # EKS CLUSTER VERSION
  cluster_version = "1.21"

  # EKS MANAGED NODE GROUPS
  managed_node_groups = {
    mg_5 = {
      node_group_name = "managed-ondemand"
      instance_types = ["m5.large"]
      min_size        = "2"
    }
  }
}

# Add-ons
module "kubernetes_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.0.2"

  eks_cluster_id = module.eks_blueprints.eks_cluster_id

  # EKS Add-ons
  enable_amazon_eks_vpc_cni    = true
  enable_amazon_eks_coredns    = true
  enable_amazon_eks_kube_proxy = true
  enable_amazon_eks_aws_ebs_csi_driver = true

  # Self-managed Add-ons
  enable_aws_for_fluentbit            = true
  enable_aws_load_balancer_controller = true
  enable_aws_efs_csi_driver           = true
  enable_cluster_autoscaler           = true
  enable_metrics_server               = true
}