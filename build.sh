#!/bin/bash

set -e
set -o pipefail

cd ..
mkdir output
cp -r caros-binary output/
mv output caros-binary/
cd caros-binary
rm output/caros-binary/build.sh
tar -zcvf output/caros-binary.tgz -C output/ caros-binary
rm -r output/caros-binary
