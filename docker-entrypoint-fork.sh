#!/bin/sh
set -eu

preserve_root="/tmp/linkstack-preserve"
rm -rf "$preserve_root"
mkdir -p "$preserve_root"

preserve_path() {
  source_path="/htdocs/$1"
  target_path="$preserve_root/$1"

  if [ -e "$source_path" ]; then
    mkdir -p "$(dirname "$target_path")"
    cp -a "$source_path" "$target_path"
  fi
}

restore_path() {
  source_path="$preserve_root/$1"
  target_path="/htdocs/$1"

  if [ -e "$source_path" ]; then
    rm -rf "$target_path"
    mkdir -p "$(dirname "$target_path")"
    cp -a "$source_path" "$target_path"
  fi
}

preserve_path ".env"
preserve_path "database/database.sqlite"
preserve_path "config/advanced-config.php"
preserve_path "assets/linkstack/images/avatar.png"
preserve_path "assets/linkstack/images/avatar@2x.png"
preserve_path "assets/linkstack/images/favicon.png"
preserve_path "assets/img"
preserve_path "storage"
preserve_path "backups"
preserve_path "themes"

cp -a /opt/linkstack-fork/. /htdocs/

restore_path ".env"
restore_path "database/database.sqlite"
restore_path "config/advanced-config.php"
restore_path "assets/linkstack/images/avatar.png"
restore_path "assets/linkstack/images/avatar@2x.png"
restore_path "assets/linkstack/images/favicon.png"
restore_path "assets/img"
restore_path "storage"
restore_path "backups"
restore_path "themes"

rm -rf "$preserve_root"

exec /usr/local/bin/docker-entrypoint.sh
