locals {
  // This is bad, but we cannot have CNAME in the zone that's called as that CNAME.
  nexus_ip     = "10.30.2.234" # nexus-master
  bitbucket_ip = "10.30.2.111"
}
