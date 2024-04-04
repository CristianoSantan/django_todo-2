FROM python:3.12.2-slim-bullseye
WORKDIR /app

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# install system dependencies
RUN apt-get update && apt-get install -y pkg-config

# install virtualenv
RUN pip install virtualenv

# create a virtual environment
RUN virtualenv /venv

# activate virtual environment and install dependencies
RUN . /venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

COPY . /app

ENTRYPOINT [ "/venv/bin/gunicorn", "setup.wsgi"]