#!/bin/bash
set -e

# --- DIAGNOSTYKA ---
echo "=========================================="
echo "DEBUG: Wartości zmiennych z HA:"
echo "DEBUG: HERMES_PASSWORD = '${HERMES_PASSWORD}' (długość: ${#HERMES_PASSWORD})"
echo "DEBUG: ALLOW_INSECURE_REMOTE = '${ALLOW_INSECURE_REMOTE}'"
echo "=========================================="
# --------------------

# Wymuszenie nasłuchiwania na wszystkich interfejsach
export HOST="0.0.0.0"

export HERMES_AGENT_URL="${HERMES_AGENT_URL}"
export HERMES_DASHBOARD_URL="${HERMES_DASHBOARD_URL}"
export HERMES_API_TOKEN="${HERMES_API_TOKEN}"
export HERMES_PASSWORD="${HERMES_PASSWORD}"
export NEXT_PUBLIC_HERMES_AGENT_URL="${HERMES_AGENT_URL}"
export NEXT_PUBLIC_HERMES_DASHBOARD_URL="${HERMES_DASHBOARD_URL}"
export VITE_HERMES_AGENT_URL="${HERMES_AGENT_URL}"
export VITE_HERMES_DASHBOARD_URL="${HERMES_DASHBOARD_URL}"

if [ "${HERMES_PASSWORD}" != "" ]; then
    echo "Password is set. Starting securely."
elif [ "${ALLOW_INSECURE_REMOTE}" = "true" ]; then
    echo "WARNING: Allowing insecure remote access (no password)!"
    export HERMES_ALLOW_INSECURE_REMOTE="1"
else
    echo "ERROR: HERMES_PASSWORD is empty and ALLOW_INSECURE_REMOTE is false."
    echo "Please set a password in add-on config, or enable 'Allow Insecure Remote'."
    sleep 5
    exit 1
fi

echo "Starting Hermes Workspace on port ${PORT}..."
exec npm start