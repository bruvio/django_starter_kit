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



RUN apk update && \
 	apk add postgresql-libs libstdc++ && \
 	apk add --virtual .build-deps build-base musl-dev postgresql-dev && \
    pip install --no-cache-dir numpy && \
    pip install --no-cache-dir pandas && \
    pip install --no-cache-dir psycopg2-binary && \
    apk --purge del .build-deps


ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}


