#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
personal_root="$(cd "$repo_root/../.." && pwd)"

service="${KEYCHAIN_SERVICE:-router-rule-openclash}"
template="${OPENCLASH_TEMPLATE:-$repo_root/Clash/provider/proxy-providers-a-b-fallback.yaml}"
output_dir="${OPENCLASH_OUTPUT_DIR:-$personal_root/personal_local_gen_station/router-rule-openclash}"
date_tag="${OPENCLASH_DATE_TAG:-$(date +%Y%m%d-%H%M%S)}"
output="${OPENCLASH_OUTPUT:-$output_dir/proxy-providers-a-b-fallback.$date_tag.local.yaml}"

read_secret() {
  local account="$1"
  security find-generic-password -s "$service" -a "$account" -w 2>/dev/null
}

sub_a_url="$(read_secret sub-a || true)"
sub_b_url="$(read_secret sub-b || true)"

if [[ -z "$sub_a_url" || -z "$sub_b_url" ]]; then
  cat >&2 <<EOF
Missing subscription URL in macOS Keychain.

Run these once, replacing the values with your real subscription URLs:
  security add-generic-password -U -s "$service" -a sub-a -w 'SUB_A_URL'
  security add-generic-password -U -s "$service" -a sub-b -w 'SUB_B_URL'
EOF
  exit 1
fi

mkdir -p "$(dirname "$output")"
chmod 700 "$(dirname "$output")"

SUB_A_URL="$sub_a_url" SUB_B_URL="$sub_b_url" perl -0pe '
  sub yaml_quote {
    my ($value) = @_;
    $value =~ s/\\/\\\\/g;
    $value =~ s/"/\\"/g;
    return "\"" . $value . "\"";
  }

  s/"订阅A地址"/yaml_quote($ENV{SUB_A_URL})/ge;
  s/"订阅B地址"/yaml_quote($ENV{SUB_B_URL})/ge;
' "$template" > "$output"

chmod 600 "$output"
echo "Rendered $output"
