{ config, ... }:
with config.lib.stylix.colors;
let 
  moduleConfiguration = {
    "niri/workspaces" = {
      format = "{icon}";
      format-icons = {
        default = "";
      };
    };

    "niri/window" = {
      format = "{}";
      separate-outputs = true;
      icon = true;
      icon-size = 18;
    };

    memory = {
      interval = 30;
      format = "<span foreground='#${base0E}'>  </span>  {used:0.1f}G/{total:0.1f}G";
      on-click = "kitty --class=htop,htop -e htop";
    };

    backlight = {
      device = "intel_backlight";
      on-scroll-up = "light -A 1";
      on-scroll-down = "light -U 1";
      format = "<span size='13000' foreground='#${base0D}'>{icon} </span>  {percent}%";
      format-icons = [
        ""
        ""
      ];
    };

    tray = {
      icon-size = 16;
      spacing = 10;
    };

    clock = {
      format = "<span foreground='#${base0E}'>  </span>  {:%a %d %H:%M}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      on-click = "kitty --class=clock,clock --title=clock -o remember_window_size=no -o initial_window_width=600 -o initial_window_height=200 -e tty-clock -s -c -C 5";
    };

    battery = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "<span size='13000' foreground='#${base0E}'>{icon}  </span>{capacity}%";
      format-warning = "<span size='13000' foreground='#${base0E}'>{icon}  </span>{capacity}%";
      format-critical = "<span size='13000' foreground='#${base08}'>{icon}  </span>{capacity}%";
      format-charging = "<span size='13000' foreground='#${base0E}'>  </span>{capacity}%";
      format-plugged = "<span size='13000' foreground='#${base0E}'>  </span>{capacity}%";
      format-alt = "<span size='13000' foreground='#${base0E}'>{icon} </span>{time}";
      format-full = "<span size='13000' foreground='#${base0E}'>  </span>{capacity}%";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
      ];
      tooltip-format = "{time}";
      interval = 5;
    };

    network = {
      format-wifi = "<span size='13000' foreground='#${base06}'>󰖩  </span>{essid}";
      format-ethernet = "<span size='13000' foreground='#${base06}'>󰤭</span> Disconnected";
      format-linked = "{ifname} (No IP) 󱚵";
      format-disconnected = "<span size='13000' foreground='#${base06}'> </span>Disconnected";
      tooltip-format-wifi = "Signal Strenght: {signalStrength}%";
      on-click = "kitty --class nmtui,nmtui --title=nmtui -o remember_window_size=no -o initial_window_width=400 -o initial_window_height=400 -e doas nmtui";
    };

    pulseaudio = {
      on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01+";
      on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01-";
      format = "<span size='13000' foreground='#${base0A}'>{icon}  </span>{volume}%";
      format-muted = "<span size='13000' foreground='#${base0A}'>  </span>Muted";
      format-icons = {
        headphone = "󱡏";
        "hands-free" = "";
        headset = "󱡏";
        phone = "";
        portable = "";
        car = "";
        default = [
          "󰕿"
          "󰖀"
          "󰕾"
          "󰕾"
        ];
      };
    };

    "group/meters" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = false;
      };
      modules = [
        "battery"
        "memory"
        "network"
        "pulseaudio"
        "backlight"
      ];
    };
  };
  otherMonitorsConfig = 
    map (name: 
      {
        layer = "top";
        postition = "top";
        output = name;
        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];
        modules-right = [
          "tray"
          "group/meters"
        ];
      } // moduleConfiguration
    );
in 
{
  programs.waybar.settings = [
    {
      position = "top";
      layer = "top";
      output = "${config.lib.monitors.mainMonitorName}";
      modules-left =  [
        "niri/workspaces"
        "tray"
        "niri/window"
      ];
      modules-center = [
        "clock"
        "memory"
      ];
      modules-right =  [
        "network"
        "pulseaudio"
        "backlight"
        "battery"
      ];
    } // moduleConfiguration
  ] ++ otherMonitorsConfig
}