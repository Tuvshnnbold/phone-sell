FROM python:3.7-alpine
LABEL maintainer="Tuvshinbold Batzorig"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py &&  \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV == "true" ];  \
      then /py/bin/pip install -r /tmp/requirements.dev.txt ;  \
    fi &&  \
    rm -rf /tmp
ENV PATH="/py/bin:$PATH"

RUN adduser -D user
RUN adduser --disabled-password --gecos '' myuser
USER user