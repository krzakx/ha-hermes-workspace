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

echo "Starting Hermes Workspace on port ${PORT}..."
exec npm start