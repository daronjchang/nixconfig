{ config, pkgs, ... }:

{
  home.username = "cdaron";
  home.homeDirectory = "/home/cdaron";

  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;
  imports = [ ./hyprland-cfg.nix ]
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enabnle = true;
  }
  nixpkgs.config.allowUnfree = true;
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
    discord
    spotify
    signal-desktop
    libreoffice
  ];
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
    extraConfig = builtins.readFile ./vimrc;
  };

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
