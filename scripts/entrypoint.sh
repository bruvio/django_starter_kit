#!/bin/sh

set -e
python manage.py wait_for_db
python manage.py makemigrations portfolio blog
python manage.py migrate
python manage.py collectstatic --no-input
python manage.py createsu
uwsgi --socket :9000 --workers 4 --master --enable-threads --module personal_portfolio.wsgi
