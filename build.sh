#!/bin/bash

rm -rf ./src/pgdbi/dist
rm -rf ./bin/pgdbi

cd ./src/web-vue
yarn build
cd ../..
cp -R ./src/web-vue/dist ./src/pgdbi/dist/
cp -R ./src/pgdbi ./bin/pgdbi/