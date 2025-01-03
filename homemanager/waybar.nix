{...}:
{
    programs.waybar = {
      enable = true;
      style = builtins.readFile ./dotfiles/waybar-style.css;

      settings = {
        mainBar = {
          height = 40;
          spacing = 4;
          modules-left = [
              #
          ];
          modules-right = [
            "memory"
            "cpu"
            "wireplumber"
            "backlight"
            "network"
            "battery"
            "clock#date"
            "clock"
          ];
          modules-center = [
            "hyprland/workspaces"
          ];
          network = {
            "format-wifi" = "{essid} ({signalStrength}%) ";
            "format-ethernet" = "{ipaddr}/{cidr} ";
            "tooltip-format" = "{ifname} via {gwaddr} ";
            "format-linked" = "{ifname} (No IP) ";
            "format-disconnected" = "Disconnected ⚠";
            "format-alt" = "{ifname}: {ipaddr}/{cidr}";
          };
          "clock#date" = {
            "format" = "{:%m/%d/%y}";
          };
          "hyprland/workspaces" = {
            "format" = "{icon}{name}{icon}";
            "format-icons" = {
              "default" = "";
              "active" = "*";
            };
          };

          "battery" = {
            "states" = {
              "warning" = 30;
              "critical" = 15;
            };
            "format" = "{capacity}% {icon}";
            "format-full" = "{capacity}% {icon}";
            "format-charging" = "{capacity}% ";
            "format-plugged" = "{capacity}% ";
            "format-alt" = "{time} {icon}";
            "format-icons" = ["" "" "" "" ""];
          };

          "pulseaudio" = {
            "format" = "{volume}% {icon} {format_source}";
            "format-bluetooth" = "{volume}% {icon} {format_source}";
            "format-bluetooth-muted" = " {icon} {format_source}";
            "format-muted" = " {format_source}";
            "format-source" = "{volume}% ";
            "format-source-muted" = "";
            "format-icons" = {
              "headphone" = "";
              "hands-free" = "";
              "headset" = "";
              "phone" = "";
              "portable" = "";
              "car" = "";
              "default" = ["" "" ""];
            };
            "on-click" = "pavucontrol";
          };

          "cpu" = {
            "interval" = 2;
            "format" = "{usage}% ";
          };

          "memory" = {
            "interval" = 30;
            "format" = "{used:0.1f}G/{total:0.1f}G ";
          };

          "wireplumber" = {
            "format" = "{volume}% {icon}";
            "format-muted" = "";
            "on-click" = "helvum";
            "format-icons" = ["" "" ""];
          };
          "backlight" = {
            #"device" = "intel_backlight";
            "format" = "{percent}% {icon}";
            "format-icons" = ["" ""];
          };
        };
      };
  };
}