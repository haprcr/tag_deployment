#!/bin/sh

terraform init -input=false

terraform plan -out=tfplan -input=false

terraform apply
