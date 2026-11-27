#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STATIC_DIR="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$STATIC_DIR/_mathjax"

mkdir -p "$BUILD_DIR"
pushd "$BUILD_DIR" >/dev/null

if [[ ! -f package.json ]]; then
    npm init -y
fi

npm install --no-save mathjax-full@3.2.0 esbuild@0.25.12

NODE_PATH="$BUILD_DIR/node_modules" npx esbuild "$SCRIPT_DIR/mathjax.js" \
    --bundle \
    --format=iife \
    --platform=browser \
    --target=es2018 \
    --loader:.woff=dataurl \
    --minify \
    --outfile="$STATIC_DIR/mathjax.min.js"

popd >/dev/null
