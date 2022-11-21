FROM python:3.11-alpine
LABEL maintainer="bruno.viola@pm.me"


# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Install and setup poetry
RUN pip install -U pip \
    && apk add --no-cache curl \
    && curl -sSL https://install.python-poetry.org | python - \
    && apk del curl
ENV PATH="${PATH}:/root/.local/bin"

RUN poetry config virtualenvs.create false



RUN apk update && \
    apk add --virtual .build-deps build-base g++ gcc libc-dev linux-headers uwsgi-python3 musl-dev postgresql-dev postgresql-libs && \
    apk add --no-cache libc-dev linux-headers libstdc++ && \
    apk --no-cache add musl-dev g++  python3-dev openblas-dev && \
    pip install --no-cache-dir numpy && \
    pip install --no-cache-dir pandas && \
    pip install --no-cache-dir psycopg2-binary && \
    pip install --no-cache-dir uwsgi && \
    apk --purge del .build-deps
# RUN apk update && \
#  	apk add --virtual .build-deps g++ gcc libc-dev linux-headers build-base uwsgi-python3 musl-dev postgresql-dev postgresql-libs libstdc++ && \
#     # pip install --no-cache-dir numpy && \
#     # pip install --no-cache-dir pandas && \
#     pip install --no-cache-dir psycopg2-binary && \
#     apk --purge del .build-deps

# RUN apk update && \
#  	apk add postgresql-libs libstdc++ && \
#  	apk add --virtual .build-deps build-base musl-dev postgresql-dev && \
#     pip install --no-cache-dir numpy && \
#     pip install --no-cache-dir pandas && \
#     pip install --no-cache-dir psycopg2-binary && \
#     apk --purge del .build-deps

RUN python -c "import pandas as pd; print('\n \n Pandas version is ',pd.__version__)"
RUN python -c "import numpy as np; print('\n \n Numpy version is ',np.__version__)"

ARG GIT_HASH
ENV GIT_HASH=${GIT_HASH:-dev}


