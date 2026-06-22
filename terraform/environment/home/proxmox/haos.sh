#!/usr/bin/env bash
set -euo pipefail

repo="home-assistant/operating-system"
asset_regex='^haos_ova-[0-9]+(\.[0-9]+)*\.qcow2\.xz$'

release_json="$(
  curl -fsSL \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/${repo}/releases/latest"
)"

asset_json="$(
  jq -r --arg re "$asset_regex" '
    .assets[]
    | select(.name | test($re))
  ' <<<"$release_json"
)"

asset_name="$(jq -r '.name' <<<"$asset_json")"
download_url="$(jq -r '.browser_download_url' <<<"$asset_json")"
checksum="$(jq -r '.digest | sub("^sha256:"; "")' <<<"$asset_json")"

cat > ./homeassistant.auto.tfvars.json <<EOF
{
  "homeassistant_image": {
    "download_url": "${download_url}",
    "save_file_name": "${asset_name%.xz}.img",
    "checksum": "${checksum}",
    "checksum_algorithm": "sha256",
    "decompression_algorithm": "zst"
  }
}
EOF
