 #!/bin/bash
export SYSTEM_ENV='NOPOSTGRES'
export SECRET_KEY='django-insecure-w=jp7h*^7occppycw4l6a*&ja%#=0_#_qwr=_&krq8e@@m*dkm'
export ADMIN_EMAIL=admin@admin.com
export ADMIN_PASSWORD=secret
export ADMIN=admin
python manage.py wait_for_db
python create_s3bucket.py
python manage.py makemigrations
python manage.py collectstatic --no-input
python manage.py migrate
python manage.py createsu
python manage.py runserver
