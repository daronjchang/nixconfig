{ config, pkgs, ... }:

{
  home.username = "cdaron";
  home.homeDirectory = "/home/cdaron";

  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;

  home.packages = with pkgs; [
    hello
    gcc
    gdb
    gnumake
    pciutils
    rustc
    cargo
    python39
    poetry
    conda
    go
    wine
    firefox
    vscode
    fzf
    nix-index
    qemu
    strace
    steam
    discord-canary
    spotify
    signal-desktop
    libreoffice
    bemenu
    fastfetch
    vulkan-tools
    steam
    cmake
    bambu-studio
    feh
    vlc
    direnv
    nix-direnv
    (writeShellScriptBin "sctlu" ''
      systemctl --user status "$1"
      '')
    (writeShellScriptBin "sctlur" ''
      systemctl restart --user status "$1"
      '')
  ];
  programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  programs.git = {
    enable = true;
    userName = "daronjchang";
    userEmail = "daronjchang@gmail.com";
  };
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-cpp-enhanced-highlight
      gruvbox
      fzf-vim
    ];
    extraConfig = builtins.readFile ./dotfiles/vimrc;
  };

  nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
  };

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
