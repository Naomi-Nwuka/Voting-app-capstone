FROM python:3.9.25-slim

# add apache bench (ab) tool
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apache2-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /seed

RUN useradd --create-home --shell /usr/sbin/nologin appuser

COPY --chown=appuser:appuser . .

# create POST data files with ab friendly formats
RUN python make-data.py

RUN chown -R appuser:appuser /seed
USER appuser

CMD ["/seed/generate-votes.sh"]
