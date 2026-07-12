ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.18

# ==========================================
# ETAP 1: Budowanie (używamy oficjalnego Node 22 na Alpine 3.18)
# ==========================================
FROM node:22-alpine3.18 AS builder

WORKDIR /opt/hermes-workspace

RUN apk add --no-cache git

RUN git clone --depth 1 --branch main \
    https://github.com/outsourc-e/hermes-workspace.git . \
    && rm -rf .git

RUN npm install
RUN npm run build
RUN npm prune --production

# ==========================================
# ETAP 2: Obraz docelowy Home Assistant
# ==========================================
FROM ${BUILD_FROM}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# KLUCZOWE: Instalujemy bibliotekę C++, której brakuje w minimalnym obrazie HA!
RUN apk add --no-cache libstdc++

# Kopiujemy binarkę Node.js
COPY --from=builder /usr/local/bin/node /usr/local/bin/node

# Kopiujemy moduły npm i ręcznie tworzymy działający link do polecenia npm
COPY --from=builder /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

# Kopiujemy gotową, zbudowaną aplikację
WORKDIR /opt/hermes-workspace
COPY --from=builder /opt/hermes-workspace /opt/hermes-workspace

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