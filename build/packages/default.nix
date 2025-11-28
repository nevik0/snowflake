{ inputs, pkgs, ... }:
let 
  invoke = file: pkgs.callPackage file { };
in 
{
  swhkd = invoke ./swhkd.nix;
  wechat = invoke ./wechat.nix;
}