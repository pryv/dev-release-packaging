#!/bin/bash

echo "executing rs.initiate()"
chpst -u mongodb /app/bin/mongodb/bin/mongo --eval 'rs.initiate()'