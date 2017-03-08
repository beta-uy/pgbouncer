import os
from string import Template

# Generate pgbouncer.ini
dbname      = os.environ['DATABASE_NAME']
host        = os.environ['DATABASE_HOST']
source_port = os.environ.get('SOURCE_PORT', 5432)
target_port = os.environ.get('TARGET_PORT', 5432)

pgbouncer_ini_tmpl = open('/etc/pgbouncer/templates/pgbouncer.ini.tmpl', 'r').read()
pgbouncer_ini_body = (
    Template(pgbouncer_ini_tmpl)
    .substitute(
        dbname = dbname,
        host = host,
        source_port = source_port,
        target_port = target_port
    )
)
pgbouncer_ini = open('/etc/pgbouncer/pgbouncer.ini', 'w')
pgbouncer_ini.write(pgbouncer_ini_body)
pgbouncer_ini.close()

# Generate users.txt
username    = os.environ['POSTGRES_USER']
password    = os.environ['POSTGRES_PASSWORD']

users_txt_tmpl = open('/etc/pgbouncer/templates/users.txt.tmpl', 'r').read()
users_txt_body = (
    Template(users_txt_tmpl)
    .substitute(
        username = username,
        password = password
    )
)
users_txt = open('/etc/pgbouncer/users.txt', 'w')
users_txt.write(users_txt_body)
users_txt.close()
