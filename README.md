# terraform_learning

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-FF9900?logo=amazonaws&logoColor=white)

My personal Terraform reference library. Each directory covers **one topic** with a small, self-contained example that you can read on its own and run on its own. All examples target AWS.

## Contents

- [Basics](#basics)
- [Resources and meta-arguments](#resources-and-meta-arguments)
- [Checks and validation](#checks-and-validation)
- [Structure and state](#structure-and-state)
- [Security](#security)
- [How to run an example](#how-to-run-an-example)

## Basics

| Directory | Topic |
|---|---|
| [`ec2_instance`](ec2_instance) | first EC2 instance |
| [`variables`](variables) | input variables and types |
| [`vars_tfvars`](vars_tfvars) | per-environment values with `dev.tfvars` / `prod.tfvars` |
| [`data_types`](data_types) | `list` and `set` |
| [`locals`](locals) | `locals` blocks |
| [`outputs`](outputs) | `output` values |
| [`datasource`](datasource) | data sources |
| [`functions`](functions) | built-in functions |
| [`zipmap_comments`](zipmap_comments) | `zipmap` and comment styles |
| [`terraform_settings`](terraform_settings) | the `terraform {}` block, required providers and versions |

## Resources and meta-arguments

| Directory | Topic |
|---|---|
| [`count`](count) | `count` |
| [`lifecycle_and_metaargs`](lifecycle_and_metaargs) | `for_each` and `lifecycle` |
| [`dependencies`](dependencies) | implicit vs explicit dependencies, `depends_on` |
| [`dynamic_block`](dynamic_block) | `dynamic` blocks and keeping code DRY |
| [`conditionals`](conditionals) | conditional expressions |
| [`security_group`](security_group) | inline rules (old style) vs `aws_vpc_security_group_*_rule` (new style) |
| [`elastic_ip`](elastic_ip) | Elastic IP |
| [`provisioners`](provisioners) | `remote-exec` and `local-exec` |

## Checks and validation

| Directory | Topic |
|---|---|
| [`validation`](validation) | `validation` rules on variables |
| [`pre-and-post-conditions`](pre-and-post-conditions) | `precondition` / `postcondition`, e.g. allow only free-tier instance types |
| [`Check_and_moved_blocks`](Check_and_moved_blocks) | `check` blocks (continuous assertions) and `moved` blocks (refactoring without destroy) |

## Structure and state

| Directory | Topic |
|---|---|
| [`modules_test`](modules_test) | writing and calling a local EC2 module |
| [`s3_backend`](s3_backend) | remote state in S3 with native locking (`use_lockfile`), plus the bucket that holds it |
| [`Targeting_resources`](Targeting_resources) | applying selected resources with `-target` |
| [`terraform_graph`](terraform_graph) | `terraform graph` with a rendered dependency graph |

## Security

| Directory | Topic |
|---|---|
| [`Security`](Security) | `sensitive` values, plus **ephemeral resources** and **write-only arguments** (`password_wo`) that create an RDS password through Secrets Manager without it ever reaching the state file |

## How to run an example

```bash
export AWS_PROFILE=<your-profile>   # or AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY
cd <directory>
terraform init
terraform plan
terraform apply
terraform destroy                   # most examples create billable resources
```

Notes:

- Files ending in `.bak` are disabled variants of an example. Terraform ignores them.
- Some examples are intentionally incomplete (for example an empty `ami`) because they show a single concept rather than a deployable stack.
- Ephemeral resources and write-only arguments need Terraform ≥ 1.11 and a recent AWS provider.
