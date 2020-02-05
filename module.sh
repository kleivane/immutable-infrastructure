#!/bin/sh

touch main.tf
touch variables.tf
touch resource.tf
touch README.md
result=${PWD##*/}
echo '#' "${PWD##*/}" >> README.md
