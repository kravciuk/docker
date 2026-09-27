#!/bin/bash
set -e

echo "Waiting for CouchDB to start..."
until curl -s http://localhost:5984/ > /dev/null; do
  sleep 1
done

set -a
source ./.env
set +a

echo "Initializing system databases..."
curl -X PUT http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@localhost:5984/_users
curl -X PUT http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@localhost:5984/_replicator
curl -X PUT http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@localhost:5984/_global_changes

echo "CouchDB initialization complete!"
