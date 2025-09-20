#!/bin/bash

echo Running tests

pip install -r requirements.txt
docker compose up --build -d
pytest tests/unit
pytest tests/integration
docker compose down --rmi all