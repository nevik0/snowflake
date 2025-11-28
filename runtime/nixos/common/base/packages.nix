{ pkgs, ... }:
with pkgs;
[
  git
  gcc
  wget
  curl
  swhkd
  cmake
  agenix
  gnumake
  nix-output-monitor
]