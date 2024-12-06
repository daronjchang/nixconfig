{pkgs, ...}:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
  ];

  environment.systemPackages = with pkgs; [
    wget
    curl
    kitty
    which
    home-manager
    gparted
    ripgrep
    dmenu
    vscode
    pavucontrol
    pciutils
    qemu
    neofetch
    shutter
    polybar
    picom
    feh
    (writeShellScriptBin "nxrb" ''
      sudo nixos-rebuild switch --flake /etc/nixos/#nixos
      '')
  ];
}

