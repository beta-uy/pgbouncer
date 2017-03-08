#!/bin/sh
set -e

[ -z "$DATABASE_NAME" ]     && echo 'Missing DATABASE_NAME'     && exit 1
[ -z "$DATABASE_HOST" ]     && echo 'Missing DATABASE_HOST'     && exit 1
[ -z "$POSTGRES_USER" ]     && echo 'Missing POSTGRES_USER'     && exit 1
[ -z "$POSTGRES_PASSWORD" ] && echo 'Missing POSTGRES_PASSWORD' && exit 1

python /render_templates.py

exec "$@"