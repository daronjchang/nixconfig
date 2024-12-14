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
#
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.greetd = {
    enable = true;
    settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "cdaron";
        };
        default_session = initial_session;
      };
    };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.printing.enable = true;
  services.openssh.enable = true;
  services.pipewire = {
     enable = true;
     pulse.enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;

  };

  users.users.cdaron = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "home-manager" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  programs.firefox.enable = true;
  services.tailscale.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";
  environment.loginShellInit = ''[[ "$(tty)" == /dev/tty1 ]] && dbus-run-session hyprland'';

}

