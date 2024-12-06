{pkgs ...}:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
  ];

  environtment.systemPacakges = with pkgs; [
    wget
    curl
    kitty
    which
    home-manager
    gparted
    ripgrep
    demnu
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

