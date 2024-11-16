#!/usr/bin/env bash
set -euo pipefail

# Usage:
#:$ ./backup_container.sh container_name
# By default container name is "dev"

if [ "$#" -eq 0 ]
then
    cname="dev"
else
    cname=$1
fi

podman container stop $cname
id=$(toolbox list | grep $cname | cut -d' ' -f1)
podman container commit -p $id $cname-backup
podman save -o $cname.tar $cname-backup
podman rmi $cname-backup

# For delete existing container use:
#:$ toolbox rm cname

# For restore container use:
#:$ podman load -i cname.tar
#:$ toolbox create --container cname --image localhost/cname-backup:latest
