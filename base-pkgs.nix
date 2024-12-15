{pkgs, ...}:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji-blob-bin
    font-awesome
  ];

  environment.systemPackages = with pkgs; [
    wget
    curl
    kitty
    which
    home-manager
    ripgrep
    vscode

    gparted
    usbutils
    pciutils

    alsa-utils
    pwvucontrol
    pavucontrol
    qemu
    neofetch
    (writeShellScriptBin "nxrb" ''
      sudo nixos-rebuild switch --flake /etc/nixos/#nixos
      '')

    (writeShellScriptBin "nxrbr" ''
      sudo nixos-rebuild switch --show-trace --verbose --flake /etc/nixos/#nixos
      '')
  ];
}

