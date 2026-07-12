ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.18
FROM ${BUILD_FROM}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Node.js and git (without version constraint - Alpine 3.18 has Node 18)
RUN apk add --no-cache \
    nodejs \
    npm \
    git

WORKDIR /opt/hermes-workspace

RUN git clone --depth 1 --branch main \
    https://github.com/outsourc-e/hermes-workspace.git . \
    && rm -rf .git

RUN npm install

RUN if [ -f "next.config.js" ] || [ -f "next.config.mjs" ] || [ -f "next.config.ts" ]; then \
        npm run build; \
    elif [ -f "vite.config.ts" ] || [ -f "vite.config.js" ]; then \
        npm run build; \
    elif grep -q '"build"' package.json 2>/dev/null; then \
        npm run build; \
    else \
        echo "No build script found, skipping build step"; \
    fi

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