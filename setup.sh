#! /usr/bin/env bash

# shellcheck disable=SC1091,SC2016

echo "Starting Nix setup"

true | sh <(curl -L https://github.com/numtide/nix-flakes-installer/releases/download/nix-2.4pre20201221_9fab14a/install) \
  --daemon \
  --darwin-use-unencrypted-nix-store-volume

# initialize `nix` for next steps - same line added to /etc/zshrc by installer
. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'

printf "\n\n\nNix installed\n\n\n"

nix flake show

printf "\n\n\nNIX version: %s\n\n\n" "$(nix --version)"

nix build .#darwinConfigurations.default.system

bat README.md

./result/sw/bin/darwin-rebuild switch --flake .

bat README.md
