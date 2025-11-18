FROM searxng/searxng:latest

# Keep the image's default settings.yml (schema-compatible)
# Only add limiter.toml to silence warning
COPY limiter.toml /etc/searxng/limiter.toml

# Ensure SearXNG uses default config path
ENV SEARXNG_SETTINGS_PATH=/etc/searxng/settings.yml

# Reduce concurrency for Koyeb free tier
ENV SEARXNG_WORKERS=1
ENV SEARXNG_THREADS=1
