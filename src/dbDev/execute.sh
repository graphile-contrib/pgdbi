#!/usr/bin/env bash
echo -d pg_phile_starter -h 0.0.0.0
echo script: $1
psql -U postgres -f $1 -d pg_phile_starter -h 0.0.0.0
