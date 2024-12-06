# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
  [
    ./hw-cfg.nix
  ];
  nixpkgs.config.allowUnfree = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixnorth"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;

  time.timeZone = "America/Chicago";

  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.windowManager.i3.enable = true;
  services.printing.enable = true;
  services.openssh.enable = true;
  services.pipewire = {
     enable = true;
     pulse.enable = true;
  };

  users.users.cdaron = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "home-manager" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  services.tailscale.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";

}

