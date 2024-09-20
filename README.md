# pub-sub-pipeline


## Setup

Replace the values in the file `terraform.tfstate.json` with your GCP project details


## Install

1. Run the following command at the root of the folder (you must ideally have owners IAM rights on the porject):
```shell 
$ terraform init
$ terraform plan
$ terraform apply
```

2. Once all resources have been created, run this from a terminal (or the Cloud Shell in the same project)
```shell
gcloud pubsub topics publish devops-log-raw-events --message='{"data": "blablabla"}' --project <PROJECT_ID>
```

This will add one line in the bigquery dataset.table