#!/bin/sh

set -e

MATCH_PATTERN=$1

. ./util.sh

image_name=${PWD##*/}

echo "====generaltao725/$image_name:test"
docker build -t "generaltao725/$image_name:test" $(dirname $(pwd))

find_args="-mindepth 1 -maxdepth 1 -type d"
if [ -n "$MATCH_PATTERN" ]; then
  find_args="$find_args -name $MATCH_PATTERN"
fi

for dir in $(find $find_args | sort); do
  dir=$(echo "$dir" | cut -c 3-)
  echo "################################################"
  echo "Now running ${dir}"
  echo "################################################"
  echo ""

  test="${dir}/run.sh"
  eval "$test"

  remove_all_docker_containers
  
  echo ""
  echo "$test passed"
  echo ""
done
