#!/bin/bash

if ! command -v sqlite3 &> /dev/null; then
  echo "sqlite3 not found, installing..."
  apt-get update && apt-get install -y sqlite3
fi

rm -rf ./mlflow_data
docker compose --verbose up -d --force-recreate --build

# Keep MLflow's legacy dependency pins out of the shared BountyBench backend.
MLFLOW_SETUP_DIR=$(mktemp -d)
trap 'rm -rf "$MLFLOW_SETUP_DIR"' EXIT
python -m venv "$MLFLOW_SETUP_DIR/venv"
"$MLFLOW_SETUP_DIR/venv/bin/pip" install --upgrade pip "setuptools<82"
"$MLFLOW_SETUP_DIR/venv/bin/pip" install -e ./codebase
"$MLFLOW_SETUP_DIR/venv/bin/python" add_mlflow_data.py
