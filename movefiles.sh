#!/bin/bash

rm -rf ./src/pgdbi/dist
rm -rf ./bin/pgdbi

cp -R ./src/web-vue/dist ./src/pgdbi/dist/
cp -R ./src/pgdbi ./bin/pgdbi/