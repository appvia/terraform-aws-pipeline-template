#!/usr/bin/env bash

SCM=${HOME}/scm
APPVIA_GITHUB=${SCM}/github.com/appvia
TEMPLATE_AWS_MODULE=${APPVIA_GITHUB}/terraform-aws-pipeline-template

/bin/cp ${TEMPLATE_AWS_MODULE}/Makefile .
/bin/cp ${TEMPLATE_AWS_MODULE}/.gitignore .
/bin/cp ${TEMPLATE_AWS_MODULE}/.tflint.hcl .
/bin/cp ${TEMPLATE_AWS_MODULE}/.terraform-docs.yml .
/bin/cp ${TEMPLATE_AWS_MODULE}/.commitlintrc.yaml .
/bin/cp ${TEMPLATE_AWS_MODULE}/SECURITY.md .
/bin/cp ${TEMPLATE_AWS_MODULE}/CODE_OF_CONDUCT.md .

if [[ -f ".terraform-docs.yaml" ]]; then
  rm -f .terraform-docs.yaml
fi
