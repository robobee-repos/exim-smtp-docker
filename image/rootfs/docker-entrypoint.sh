#!/bin/bash
set -xe

echo "Running as `id`"

bash -x /bin/entrypoint.sh

exec "$@"
