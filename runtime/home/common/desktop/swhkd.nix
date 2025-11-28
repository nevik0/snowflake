{config, nevik, ...}: {
  xdg.configFile."swhkd/basic.swhkdrc".text = nevik.mkSwhkdrc {
    keyBindings = [
      {
        key = "super + shift + r";
        command = "pkill -HUP swhkd";
      }
      {
        key = "super + alt + c";
        command = "wl-color-picker";
      }
      {
        key = "XF86AudioMute";
        command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      }
      {
        key = "XF86AudioMicMute";
        command = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      }
      {
        key = "XF86AudioRaiseVolume";
        command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
      }
      {
        key = "XF86AudioLowerVolume";
        command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
      }
      {
        key = "super + shift + s";
        command = with config.lib.stylix.colors.withHashtag; ''wshowkeys -a bottom -a right -F "Comic Code 30" -b "${base00}aa" -f "${base0E}ee" -s "${base0F}ee" -t 1'';
      }
      {
        key = "XF86MonBrightnessUp";
        command = "brightnessctl set 5%+";
      }
      {
        key = "XF86MonBrightnessDown";
        command = "brightnessctl set 5%-";
      }
    ];
  };
  xdg.configFile."swhkd/tools.swhkdrc".text = nevik.mkSwhkdrc {
    keyBindings = [
      {
        key = "super + x";
        command = "wlogout";
      }
    ];
  };
}
