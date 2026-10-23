# Base image
FROM python:3.11-slim-bookworm AS base

# Update operating system packages and install curl
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*

# Application directory
WORKDIR /usr/local/app

# Create a non-root user
RUN useradd --create-home --shell /usr/sbin/nologin appuser

# Update Python build tools and install application dependencies
RUN python -m pip install --no-cache-dir --upgrade pip setuptools wheel

COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Development stage
FROM base AS dev

RUN pip install --no-cache-dir watchdog

ENV FLASK_ENV=development

CMD ["python", "app.py"]

# Production stage
FROM base AS final

COPY --chown=appuser:appuser . .

EXPOSE 80

USER appuser

CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80", "--log-file", "-", "--access-logfile", "-", "--workers", "4", "--keep-alive", "0"]