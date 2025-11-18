# SearXNG on Koyeb (Free tier)

This repo contains a minimal Dockerized SearXNG setup tuned for Koyeb’s free tier. It uses the official `searxng/searxng` image and a small `settings.yml` you can customize.

What you get:
- Simple Dockerfile that injects your `settings.yml`
- Config wired to environment variables for secrets and the Koyeb domain
- Minimal set of engines to keep resource usage low

## Files

- `Dockerfile`: Builds from `searxng/searxng:latest` and copies configuration.
- `settings.yml`: SearXNG configuration. The `server.base_url` and `server.secret_key` are read from environment variables.

## Quick Deploy to Koyeb

Prerequisites:
- A Koyeb account (Free plan is enough)
- A Git provider (e.g., GitHub) with this repository pushed

Steps:
1) Push this repo to GitHub (or another supported provider).
2) In the Koyeb dashboard: Create App → Deploy a Service → GitHub → select this repo/branch.
3) Build settings: Choose “Dockerfile” (this repo includes one at the root).
4) Ports: Set the exposed port to `8080` with HTTP protocol.
5) Instance type: Select the free tier instance.
6) Environment variables (add these):
   - `SEARXNG_SETTINGS_PATH=/etc/searxng/settings.yml`
   - `SEARXNG_SECRET_KEY=<generate a long random string>`
   - `SEARXNG_BASE_URL=https://<your-app>.koyeb.app/`  (note the trailing slash)
   - Optional: `BRAVE_API_KEY=<your key>` if you enable the Brave engine in `settings.yml`.
7) Click Deploy.

After the first deployment, confirm your assigned Koyeb domain (e.g., `https://searxng-<xyz>.koyeb.app/`). If you didn’t set `SEARXNG_BASE_URL` yet, add/update it and redeploy. The URL must end with a trailing `/`.

## Generating the secret key

Use any method to create a long random string. For example, locally:

PowerShell:
```
[Convert]::ToBase64String((1..48 | ForEach-Object {Get-Random -Maximum 256}))
```

Python:
```
python -c "import secrets; print(secrets.token_urlsafe(48))"
```

Set the generated value as `SEARXNG_SECRET_KEY` in Koyeb.

## Changing search engines

The default `settings.yml` enables a small, low-overhead set of engines. To enable more:
- Edit `settings.yml` engines, set `disabled: false` where desired.
- If an engine requires an API key, provide it via an environment variable and reference it using `ENV:<VAR>` in `settings.yml`.
- Redeploy from Koyeb; no code changes are needed.

## Notes

- Ensure `SEARXNG_BASE_URL` matches the domain you actually use and includes a trailing slash.
- The app listens on port `8080` inside the container; configure Koyeb to route HTTP traffic to that port.
- Koyeb deployments are ephemeral; this setup stores no state on disk.
