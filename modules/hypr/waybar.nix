{ ... }: {
  flake.modules.homeManager.waybar = { ... }: {
    imports = [
      ./modules/clock.nix
      ./modules/cpu.nix
      ./modules/memory.nix
      ./modules/temperature.nix
      ./modules/language.nix
      ./modules/pulseaudio.nix
      ./modules/network.nix
      ./modules/power.nix
      ./modules/battery.nix
      ./modules/backlight.nix
      ./modules/notification.nix
    ];
    programs.waybar = {
      enable = true;
      style = ./style.css;
      settings.main = {
        layer = "top";
        modules-left = [
          "tray"
          "clock"
          "cpu"
          "memory"
          "temperature"
          "hyprland/language"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "pulseaudio"
          "network"
          "power-profiles-daemon"
          "battery"
          "backlight"
          "custom/notification"
        ];
        clock.tooltip-format = "{:%d-%m-%Y}";
        cpu = {
          format = "  {}%";
          interval = 5;
        };
        memory = {
          format = "  {}%";
          interval = 5;
        };
        temperature = {
          format = " {}°C";
          tooltip = false;
          interval = 5;
        };
        "hyprland/language" = {
          format-en = "EN";
          format-da = "DK";
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
            headphone = "󰋋";
            headset = "󰋋";
          };
        };
        network = {
          format = "{ifname}";
          format-wifi = "{icon}";
          format-ethernet = "";
          format-disconnected = "";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          tooltip-format = "{ifname}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-disconnected = "Disconnected";
        };
        power-profiles-daemon = {
          format = "{icon}";
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "󰌪";
          };
          tooltip = false;
        };
        battery = {
          states = {
            good = 80;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-icons = [
            "󰂎"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          tooltip-format = "Discharging: {time}";
          tooltip-format-charging = "Charging: {time}";
          interval = 30;
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = [
            "󰃜"
            "󰃛"
            "󰃚"
          ];
          tooltip = false;
        };
        "custom/notification" = {
          format = "{icon}";
          format-icons = {
            notification = "󱅫";
            none = "󰂜";
            dnd-notification = "󰂠";
            dnd-none = "󰪓";
            inhibited-notification = "󰂛";
            inhibited-none = "󰪑";
            dnd-inhibited-notification = "󰂛";
            dnd-inhibited-none = "󰪑";
          };
          tooltip = true;
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };
  };
}
