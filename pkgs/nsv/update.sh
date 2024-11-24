#!/bin/bash

set -euxo pipefail

version=$1

function get_hash() {
	nix hash convert --hash-algo sha256 --to sri $(nix-prefetch-url https://github.com/purpleclay/nsv/releases/download/v${version}/nsv_${version}_${1}.tar.gz)
}

cat <<EOF
  shaMap = {
    x86_64-linux = "$(get_hash linux_x86_64)";
    armv7l-linux = "$(get_hash linux_armv7)";
    aarch64-linux = "$(get_hash linux_arm64)";
    x86_64-darwin = "$(get_hash darwin_x86_64)";
    aarch64-darwin = "$(get_hash darwin_arm64)";
  };

  urlMap = {
    x86_64-linux = "https://github.com/purpleclay/nsv/releases/download/v${version}/nsv_${version}_linux_x86_64.tar.gz";
    armv7l-linux = "https://github.com/purpleclay/nsv/releases/download/v${version}/nsv_${version}_linux_armv7.tar.gz";
    aarch64-linux = "https://github.com/purpleclay/nsv/releases/download/v${version}/nsv_${version}_linux_arm64.tar.gz";
    x86_64-darwin = "https://github.com/purpleclay/nsv/releases/download/v${version}/nsv_${version}_darwin_x86_64.tar.gz";
    aarch64-darwin = "https://github.com/purpleclay/nsv/releases/download/v${version}/nsv_${version}_darwin_arm64.tar.gz";
  };
EOF
