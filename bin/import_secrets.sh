#!/bin/bash

secret_files=(
  .mutt_private
  .pwsafe.dat
  .ssh
  .ssh/id_rsa
  .ssh/id_rsa.pub
)

if [[ $# -ne 1 ]]; then
  echo "Usage: import_secrets.sh SOURCE_PATH"
  exit 1
fi

source_path=${@%/}
destination_path="$HOME"

if [[ ! -d $source_path ]]; then
  echo "Error: source path does not exist."
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
    cp -pr "$dst" "$dst.backup"
    rm -rf "$dst"
  fi
  if [[ -d $src ]]; then
    mkdir -p "$dst"
    chmod 700 "$dst"
  else
    cp "$src" "$dst"
    chmod 600 "$dst"
  fi
  echo "Imported: $secret_file"
done

exit 0
