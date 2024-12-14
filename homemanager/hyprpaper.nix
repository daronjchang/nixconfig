{ config, ... }:

let
  _ = builtins.trace "Loaded: hyprpaper.nix" null;
in
{
  # Example module configuration
  home.file.".config/hypr/hyprpaper.conf".text = ''
    wallpaper = /path/to/wallpaper.jpg
  '';
}