FROM searxng/searxng:latest

# Copy your custom config into the container
COPY settings.yml /etc/searxng/settings.yml

# (optional but explicit)
ENV SEARXNG_SETTINGS_PATH=/etc/searxng/settings.yml
