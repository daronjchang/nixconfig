# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
    ./hardware-configuration.nix
    ];
   nixpkgs.config.allowUnfree = true;
   # Use the systemd-boot EFI boot loader.
   boot.loader.systemd-boot.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;
   boot.kernelPackages = pkgs.linuxPackages_latest;

   networking.hostName = "nixnorth"; # Define your hostname.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
   networking.useDHCP = false;
   networking.interfaces.eno1.useDHCP = true;
   
   time.timeZone = "America/Chicago";

  # Enable the X11 windowing system.
   services.xserver.enable = true;
  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.windowManager.i3.enable = true;
  #Enable CUPS to print docs
  services.printing.enable = true;

   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
     users.users.cdaron = {
	initialPassword ="123";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "home-manager" "docker" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      ];
    };

    programs.firefox.enable = true;
    services.tailscale.enable = true;

  #Flakes
  #programs.nix-ld.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  

    environment.systemPackages = with pkgs; [
      wget
      git
      binutils
      curl
      which
      home-manager
      gparted
      pavucontrol
      dmenu
      neofetch
      shutter 
      polybar
      ripgrep
      pavucontrol
      kitty
      picom
      feh
    ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
  system.stateVersion = "24.11"; # Did you read the comment?

}

