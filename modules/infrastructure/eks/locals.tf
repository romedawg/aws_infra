locals {
  // See SSP-388 for details
  // IAM group whose members are part of the metarouter company.
  // Metarouter is a third party vendor that has deployed software into our EKS cluster.
  // They need some restricted access to EKS in order to administer this software.
  metarouter_group = "global-engineering-Metarouter-VI4B711LYDPX"

  // IAM group whose members consist of senior software engineers that are entitled
  // to super admin access to the EKS clusters in order to administer them.
  operators_group = "Operators"
}

