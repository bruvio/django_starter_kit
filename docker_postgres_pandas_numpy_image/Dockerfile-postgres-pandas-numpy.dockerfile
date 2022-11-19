FROM python:3.9-alpine
LABEL maintainer="bruno.viola@pm.me"


# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Install and setup poetry
RUN pip install -U pip \
    && apk add --no-cache curl \
    && curl -sSL curl -sSL https://install.python-poetry.org | python -
ENV PATH="${PATH}:/root/.local/bin"

RUN poetry config virtualenvs.create false






RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN apk add g++ postgresql-dev gcc python3-dev libffi-dev musl-dev zlib-dev jpeg-dev
RUN apk add --no-cache bash && apk upgrade expat \
    && rm -rf /var/cache/apk/*

RUN apk del .tmp-build-deps

RUN pip install --upgrade pip && pip install --no-cache-dir numpy pandas

ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}


