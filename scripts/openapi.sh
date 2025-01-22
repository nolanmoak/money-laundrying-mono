#!/bin/bash

API_URL="http://localhost:5293/openapi/v1.json"
OUTPUT_PATH="./frontend/openapi/spec.json"

echo "Fetching OpenAPI spec..."
curl $API_URL -o $OUTPUT_PATH

echo "OpenAPI spec exported to $OUTPUT_PATH"
