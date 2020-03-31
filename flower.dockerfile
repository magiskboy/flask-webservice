FROM python:3.7-alpine

LABEL maintainer="nguyenkhacthanh244@gmail.com" version="1.0"

WORKDIR /app

RUN apk update --no-cache &&\
    apk add --no-cache gcc musl-dev libffi-dev openssl-dev

ADD requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

ADD app ./app

EXPOSE 5555

ENTRYPOINT celery flower -A app.jobs.manager --address=0.0.0.0 --port=5555 --broker_api=$BROKER_API

CMD /bin/sh
