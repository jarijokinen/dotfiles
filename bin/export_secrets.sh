#!/bin/bash

secret_files=(
  .mutt_private
  .pwsafe.dat
  .ssh
  .ssh/id_rsa
  .ssh/id_rsa.pub
)

if [[ $# -ne 1 ]]; then
  echo "Usage: export_secrets.sh DESTINATION_PATH"
  exit 1
fi

destination_path=${@%/}
source_path="$HOME"

if [[ ! -d $destination_path ]]; then
  echo "Error: destination path does not exist."
  exit 1
fi

for secret_file in ${secret_files[@]}; do
  src="$source_path/$secret_file"
  dst="$destination_path/$secret_file"
  if [[ ! -e $src ]]; then
    echo "Not found: $src"
    echo "Aborting!"
    exit 1
  fi
  if [[ -e $dst ]]; then
    echo "Already exists: $secret_file"
    continue
  fi
  if [[ -d $src ]]; then
    mkdir -p "$dst"
    chmod 700 "$dst"
  else
    cp "$src" "$dst"
    chmod 600 "$dst"
  fi
  echo "Exported: $secret_file"
done

exit 0
