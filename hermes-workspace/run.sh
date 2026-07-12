#!/bin/bash
set -e

if [ -n "${HERMES_AGENT_URL}" ]; then
    export HERMES_AGENT_URL="${HERMES_AGENT_URL}"
    export NEXT_PUBLIC_HERMES_AGENT_URL="${HERMES_AGENT_URL}"
    export VITE_HERMES_AGENT_URL="${HERMES_AGENT_URL}"
fi

if [ -n "${HERMES_DASHBOARD_URL}" ]; then
    export HERMES_DASHBOARD_URL="${HERMES_DASHBOARD_URL}"
    export NEXT_PUBLIC_HERMES_DASHBOARD_URL="${HERMES_DASHBOARD_URL}"
    export VITE_HERMES_DASHBOARD_URL="${HERMES_DASHBOARD_URL}"
fi

if [ -n "${HERMES_API_TOKEN}" ]; then
    export HERMES_API_TOKEN="${HERMES_API_TOKEN}"
fi

if [ -n "${HERMES_PASSWORD}" ]; then
    export HERMES_PASSWORD="${HERMES_PASSWORD}"
fi

if [ "${COOKIE_SECURE}" = "true" ]; then
    export COOKIE_SECURE="true"
else
    export COOKIE_SECURE="false"
fi

if [ "${TRUST_PROXY}" = "true" ]; then
    export TRUST_PROXY="true"
else
    export TRUST_PROXY="false"
fi

echo "=========================================="
echo "Starting Hermes Workspace..."
echo "=========================================="
echo "  Hermes Agent URL:  ${HERMES_AGENT_URL}"
echo "  Dashboard URL:     ${HERMES_DASHBOARD_URL}"
echo "  API Token:         $(if [ -n "${HERMES_API_TOKEN}" ]; then echo "***SET***"; else echo "***NOT SET***"; fi)"
echo "  Password:          $(if [ -n "${HERMES_PASSWORD}" ]; then echo "***SET***"; else echo "***NOT SET***"; fi)"
echo "  Cookie Secure:     ${COOKIE_SECURE}"
echo "  Trust Proxy:       ${TRUST_PROXY}"
echo "  Port:              ${PORT}"
echo "=========================================="

if grep -q '"start"' package.json 2>/dev/null; then
    exec npm start
elif grep -q '"preview"' package.json 2>/dev/null; then
    exec npm run preview -- --host 0.0.0.0 --port 3000
elif grep -q '"dev"' package.json 2>/dev/null; then
    exec npm run dev -- --host 0.0.0.0 --port 3000
else
    echo "ERROR: No suitable start script found in package.json"
    echo "--- package.json content ---"
    cat package.json
    echo "-----------------------------"
    exit 1
fi