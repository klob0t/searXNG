FROM searxng/searxng:latest

# Use our minimal config and limiter file to keep logs clean
COPY settings.yml /etc/searxng/settings.yml
COPY limiter.toml /etc/searxng/limiter.toml

# Point SearXNG to the config we ship
ENV SEARXNG_SETTINGS_PATH=/etc/searxng/settings.yml

# Reduce concurrency for Koyeb free tier
ENV SEARXNG_WORKERS=1
ENV SEARXNG_THREADS=1
