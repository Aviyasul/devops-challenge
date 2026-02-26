#!/usr/bin/env bash
set -e

HOST="localhost"
PORT="30080"
URL="http://${HOST}:${PORT}/"
MAX_RETRIES=30
WAIT_SECONDS=10

echo "Starting smoke test against ${URL}"

for i in $(seq 1 $MAX_RETRIES); do
  echo "Attempt ${i}/${MAX_RETRIES}..."

  RESPONSE=$(curl --silent --max-time 5 "${URL}" || true)

  if echo "${RESPONSE}" | grep -q "200 OK"; then
    echo "✅ SUCCESS: Application is running!"
    exit 0
  fi

  echo "Not ready yet. Waiting ${WAIT_SECONDS}s..."
  sleep $WAIT_SECONDS
done

echo "❌ FAILED: Application did not respond after $((MAX_RETRIES * WAIT_SECONDS))s"
exit 1