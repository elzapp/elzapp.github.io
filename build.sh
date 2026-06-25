#!/bin/bash
# Local build. Tools (Hugo) are pinned in mise.toml.
set -euo pipefail

mise install
git submodule update --init themes/ananke
mise exec -- hugo --gc --minify "$@"
