## Commands

to enable `terraform fmt` and `terragrunt hclfmt` before commits:

```
cd <DIR_REPO>
ln -s ../../.pre-commit .git/hooks/pre-commit
```

to enable `git pull origin main`, `tflint`, `tfsec`, `terragrunt input validate`, `terragrunt validate` and `terragrunt plan` after commits:

```
cd <DIR_REPO>
ln -s ../../.post-commit .git/hooks/post-commit
tflint --init
``````