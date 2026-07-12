ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.18
FROM ${BUILD_FROM}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install git, curl, then Node.js 22 via NodeSource
RUN apk add --no-cache curl git \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | sh - \
    && apk add --no-cache nodejs

WORKDIR /opt/hermes-workspace

RUN git clone --depth 1 --branch main \
    https://github.com/outsourc-e/hermes-workspace.git . \
    && rm -rf .git

RUN npm install

# Aplikacja używa Vite, więc po prostu odpalamy build
RUN npm run build

RUN npm prune --production 2>/dev/null || true

ENV PORT=3000
ENV HOSTNAME="0.0.0.0"
ENV NODE_ENV=production
ENV HERMES_AGENT_URL="http://addon_0a6523c6_hermes_agent:8080"
ENV HERMES_DASHBOARD_URL="http://addon_0a6523c6_hermes_agent:8080/dashboard"
ENV HERMES_API_TOKEN=""
ENV HERMES_PASSWORD=""
ENV COOKIE_SECURE="false"
ENV TRUST_PROXY="false"
ENV NEXT_PUBLIC_HERMES_AGENT_URL="http://addon_0a6523c6_hermes_agent:8080"
ENV NEXT_PUBLIC_HERMES_DASHBOARD_URL="http://addon_0a6523c6_hermes_agent:8080/dashboard"
ENV VITE_HERMES_AGENT_URL="http://addon_0a6523c6_hermes_agent:8080"
ENV VITE_HERMES_DASHBOARD_URL="http://addon_0a6523c6_hermes_agent:8080/dashboard"

EXPOSE 3000

COPY run.sh /
RUN chmod +x /run.sh

CMD ["/run.sh"]
EOF