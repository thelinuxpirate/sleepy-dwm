# The Sleepy NixOS Module
{ config, pkgs, lib, ... }:

let
  dmenu = pkgs.callPackage ../default.nix { app = "dmenu"; nixpkgs = pkgs; };
  st = pkgs.callPackage ../default.nix { app = "st"; nixpkgs = pkgs; };
  slstatus = pkgs.callPackage ../default.nix { app = "slstatus"; nixpkgs = pkgs; };
in
{
  options.sleepy.enableDmenu = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable the Sleepy Dmenu build.";
  };

  options.sleepy.enableSlstatus = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable the Sleepy Slstatus build.";
  };

  options.sleepy.enableST = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable the Sleepy ST build.";
  };

  config = {
    environment.systemPackages = lib.optionals config.sleepy.enableDmenu [
      dmenu
    ] ++ lib.optionals config.sleepy.enableSlstatus [
      slstatus
    ] ++ lib.optionals config.sleepy.enableST [
      st
    ];
  };
}
