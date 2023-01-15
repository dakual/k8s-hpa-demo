FROM python:3.9-slim

LABEL app="k8s hpa demo"
LABEL maintener="daghan"
LABEL major_version="1"
LABEL minor_version="0"

RUN apt-get update && \
    apt-get install -y stress && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY app/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

ENV FLASK_APP /app/app.py
ENV FLASK_APP_PORT 8000
ENV FLASK_APP_HOST "0.0.0.0"
ENV FLASK_APP_LOG "--access-logfile"
ENV FLASK_APP_LOG_FILE "'-'"

ENV GUNICORN_CMD_ARGS "--bind=$FLASK_APP_HOST:$FLASK_APP_PORT $FLASK_APP_LOG $FLASK_APP_LOG_FILE"

COPY app .

CMD [ "gunicorn", "app:app"]
