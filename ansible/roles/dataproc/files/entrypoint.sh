#!/bin/bash
# FIX: was #!/bin/sh. In python:3.10-slim sh is dash, which has no arrays,
# so the ARGS line below was a syntax error.
echo "Starting Data Processor..."
# Legacy argument parsing
ARGS=("api" "--port" "5000")
exec python3 app.py "${ARGS[@]}"
