#!/bin/bash

rm -rf ./src/pgi/dist
rm -rf ./bin/pgi

cp -R ./src/web-vue/dist ./src/pgi/dist/
cp -R ./src/pgi ./bin/pgi/