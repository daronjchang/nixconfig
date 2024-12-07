{
  pkgs,
  lib,
  username,
  host,
  config,
  ...
}:

let
  inherit (import ../hosts/${host}/variables.nix)
    browser
    terminal
    extraMonitorSettings
    keyboardLayout
    ;
in
with lib;
{
   wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enabnle = true;
  }
}