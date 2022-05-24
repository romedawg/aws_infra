# Generic terraform module

Used by ansible tests to create/destroy workspaces by passing in
 - project_path
   - This is the terraform workspace you intend to apply/destroy(aka terraform-aws/workspaces/aws-qa)
 - state [present|absent]
 - terraform_version
 - cluster(this is for the terraform module)
 - include_logrouter(if necessary)
   - will create logrouter-<cluster_name> service

# Example Usage
```
 - name: terraform apply zookeeper workspace
   collections: common
   include_role:
     name: terraform_workspace
   vars:
     project_path: '{{ root_dir }}/gohealth/zookeeper/terraform-workspace/zookeeper'
     state: present
     terraform_version: 0.13.6
     # this is a variable passed into the terraform-module(aka test-id so deployments are unique)
     cluster: "{{ cluster }}"
     include_logrouter: true|false
     
  - name: terraform destroy zookeeper workspace
   collections: common
   include_role:
     name: terraform_workspace
   vars:
     project_path: '{{ root_dir }}/gohealth/zookeeper/terraform-workspace/zookeeper'
     state: absent
     terraform_version: 0.13.6
     # this is a variable passed into the terraform-module(aka test-id so deployments are unique)
     cluster: "{{ cluster }}"
     include_logrouter: true|false
```
