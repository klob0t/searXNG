FROM searxng/searxng:latest

# Use the image's default config (schema-compatible)
# You can reintroduce a custom settings.yml later once stable
ENV SEARXNG_SETTINGS_PATH=/etc/searxng/settings.yml
