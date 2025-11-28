{
  description = "Nevik's NixOS Configurations and Home-Manager Configurations.";

  inputs = {
    # Age-based secret encryption/decryption
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    # Catppuccin Themes
    catppuccin.url = "github:catppuccin/nix";
    # Disk partitioning and filesystem automation
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    # Home-manager – per-user NixOS-style configuration
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nh – fast, friendly nixos-rebuild/home-manager wrapper
    nh.url = "github:nix-community/nh";
    nh.inputs.nixpkgs.follows = "nixpkgs";
    # Declarative Flatpak management for NixOS
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    # nixd – high-performance Nix language server
    nixd.url = "github:nix-community/nixd";
    nixd.inputs.nixpkgs.follows = "nixpkgs";
    # Official NixOS package collection (bleeding-edge)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # NUR – community-maintained user repositories overlay
    nixpkgs-nur.url = "github:nix-community/NUR";
    # Upstream nixpkgs development branch
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    # Latest NixOS stable release branch
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    # Wayland-specific packages and overrides
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    # OpenGL/Vulkan helpers for proprietary drivers on Nix
    nixGL.url = "github:nix-community/nixGL";
    # Hardware-specific modules and tweaks
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # Niri – scrollable tiling Wayland compositor
    niri.url = "github:sodiboo/niri-flake";
    # nvf – batteries-included Neovim flake
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    # Stylix – system-wide theming made simple
    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    # Systems - nixos supported system architectures
    systems.url = "github:nix-systems/default";
    # Treefmt-nix – unified formatting pipeline
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    self,
    systems,
    ...
  }@inputs:
  let 
    build = import ./build { inherit nixpkgs systems inputs; };
    runtime = import ./runtime { inherit self inputs; };
    operate = import ./operate;
  in 
  {
    inherit (operate) templates;

    inherit (runtime) homeConfigurations nixosConfigurations;
  
    inherit (build) lib overlays packages devShells formatter homeModules nixosModules;
  };
}