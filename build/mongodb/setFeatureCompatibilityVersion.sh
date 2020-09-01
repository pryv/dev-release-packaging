#!/bin/bash

chpst -u mongodb /app/bin/mongodb/bin/mongo --eval 'db.adminCommand( { setFeatureCompatibilityVersion: "4.0" } )'