#!/bin/sh
set -e

[ -z "$DATABASE_NAME" ]     && echo 'Missing DATABASE_NAME'     && exit 1
[ -z "$DATABASE_HOST" ]     && echo 'Missing DATABASE_HOST'     && exit 1
[ -z "$DATABASE_USER" ]     && echo 'Missing DATABASE_USER'     && exit 1
[ -z "$DATABASE_PASSWORD" ] && echo 'Missing DATABASE_PASSWORD' && exit 1

python /render_templates.py

exec "$@"