{pkgs, ...}:
{
    home.packages = with pkgs; [
        fuzzel
        waybar
        hyprshot
        hyprcursor
        hyprlock
        hypridle
        hyprpaper
    ];

    wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = true;
        xwayland.enable = true;
        settings = let
            mainMod = "SUPER";
        in {
            xwayland = {
                force_zero_scaling = true;
            };
            exec-once = [
                # regular copy-paste
                "wl-clipboard-history -t"
                "wl-paste --watch cliphist store"
                #bar
                "waybar"
                "spotify"
                "signal"
                "discord-canary"
            ];

            "windowrulev2" = [
                # "suppressevent maximize, class:.*"
                "workspace special:Signal silent,class:^(signal)$"
                "workspace special:Signal silent,class:^(Signal)$"
                "workspace special:Discord silent,class:^(discord)$"
                "workspace special:Spotify silent,class:^(spotify)$"
            ];

            general = {
                gaps_in = 5;
                gaps_out = 10;
                border_size = 2;

                # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
                "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";

                # Set to true enable resizing windows by clicking and dragging on borders and gaps
                resize_on_border = false;

                # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
                allow_tearing = false;

                layout = "dwindle";
            };

            decoration = {
                rounding = 10;

                # Change transparency of focused and unfocused windows
                active_opacity = 1.0;
                inactive_opacity = 1.0;

                #drop_shadow = true;
                #shadow_range = 4;
                #shadow_render_power = 3;
                #"col.shadow" = "rgba(1a1a1aee)";

                # https://wiki.hyprland.org/Configuring/Variables/#blur
                blur = {
                    enabled = true;
                    size = 3;
                    passes = 1;

                    vibrancy = 0.1696;
                };
            };
            animations = {
                enabled = true;

                # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

                bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

                animation = [
                    "windows, 1, 7, myBezier"
                    "windowsOut, 1, 7, default, popin 80%"
                    "border, 1, 10, default"
                    "borderangle, 1, 8, default"
                    "fade, 1, 7, default"
                    "workspaces, 1, 6, default"
                ];
            };

            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            dwindle = {
                pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = true; # You probably want this
            };

            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            master = {
                new_status = "master";
            };
            binds = {
                pass_mouse_when_bound = true;
            };
            # https://wiki.hyprland.org/Configuring/Variables/#misc
            misc = {
                force_default_wallpaper = 2; # Set to 0 or 1 to disable the anime mascot wallpapers
                disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
            };

            # https://wiki.hyprland.org/Configuring/Variables/#input
            input = {
                kb_layout = "us";
                kb_options = "grp:caps_toggle";

                follow_mouse = 1;

                sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

                touchpad = {
                    natural_scroll = false;
                };
            };

            # https://wiki.hyprland.org/Configuring/Variables/#gestures
            # Enable touchpad gestures
            gestures = {
                workspace_swipe = true;
                workspace_swipe_fingers = 3;
            };

            bind = [
                #"${mainMod}, SPACE, exec, cliphist list | fuzzel -d  | cliphist decode | wl-copy"
                "${mainMod}, F, fullscreen, 2"
                "${mainMod}, RETURN, exec, kitty"
                "${mainMod}, Q, killactive,"
                "${mainMod}, M, exit,"
                "${mainMod}, H, movewindow, l"
                "${mainMod}, J, movewindow, d,"
                "${mainMod}, K, movewindow, u"
                "${mainMod}, L, movewindow, r"
                "${mainMod}, V, togglefloating,"
                "${mainMod}, P, pseudo, # dwindle"
                "${mainMod}, S, togglesplit, # dwindle"
                "${mainMod}, D, exec, fuzzel"
                "${mainMod}, C, exec, code --enable-features=UseOzonePlatform --ozone-platform=wayland"
                "${mainMod}, left, movefocus, l"
                "${mainMod}, right, movefocus, r"
                "${mainMod}, up, movefocus, u"
                "${mainMod}, down, movefocus, d"
                "${mainMod}, mouse_down, workspace, e+1"
                "${mainMod}, mouse_up, workspace, e-1"
                "${mainMod} SHIFT, R, exec, hyprshot -m region --clipboard-only"
                "${mainMod} SHIFT, A, togglespecialworkspace, Signal"
                "${mainMod} SHIFT, S, togglespecialworkspace, Spotify"
                "${mainMod} SHIFT, W, togglespecialworkspace, Discord"
                ",XF86AudioMute,exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ] ++ (
                # workspaces
                # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
                builtins.concatLists (builtins.genList (
                    x: let
                    ws = let
                        c = (x + 1) / 10;
                    in
                        builtins.toString (x + 1 - (c * 10));
                    in [
                    "${mainMod}, ${ws}, workspace, ${toString (x + 1)}"
                    "${mainMod} SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                    ]
                )
                10)
            );
            bindm = [
                "${mainMod}, mouse:272, movewindow"
                "${mainMod}, mouse:273, resizewindow"
            ];
            binde = [
                ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+"
                ",XF86AudioLowerVolume, exec, wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%-"
                ",XF86MonBrightnessUp, exec, sudo light -A 5"
                ",XF86MonBrightnessDown, exec, sudo light -U 5"
            ];

        };
    };
}
