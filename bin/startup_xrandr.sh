#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
"$script_dir/setup-displays"
nitrogen --restore
