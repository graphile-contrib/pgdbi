#!/usr/bin/env bash
echo -d soro_sales -h 0.0.0.0
echo script: $1
psql -U postgres -f $1 -d soro_sales -h 0.0.0.0
