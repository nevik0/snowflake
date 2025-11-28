{ config, lib, ... }:
let 
  inherit 
    (config.lib.stylix.colors.withHashtag)
    base00
    base01
    base04
    base05
    base06
    base07
    base08
    base0A
    base0B
    base0D
    base0E
    base0F
    ;
  inherit (config.lib.formats.rasi) mkLiteral;
  inherit (import ./lib.nix { inherit lib; }) toRasi;
in 
{
  programs.waybar.style = toRasi {
    "@keyframes gradient" = {
      "0%" = {
        background-position = mkLiteral "0% 50%";
      };
      "50%" = {
        background-position = mkLiteral "100% 30%";
      };
      "100%" = {
        background-position = mkLiteral "0% 50%";
      };
    };

    "@keyframes gradient_f" = {
      "0%" = {
        background-position = mkLiteral "0% 200%";
      };
      "50%" = {
        background-position = mkLiteral "200% 0%";
      };
      "100%" = {
        background-position = mkLiteral "400% 200%";
      };
    };

    "@keyframes gradient_f_nh" =  {
      "0%" = {
        background-position = mkLiteral "0% 200%";
      };
      "100%" = {
        background-position = mkLiteral "200% 200%";
      };
    };

    "@keyframes gradient_rv" = {
      "0%" = {
        background-position = mkLiteral "200% 200%";
      };
      "100%" = {
        background-position = mkLiteral "0% 200%";
      };
    };

    "*" = {
      font-size = mkLiteral "14px";
      font-family = "${config.stylix.fonts.sansSerif.name}";
      min-height = mkLiteral "0px";
    };

    "window#waybar" = {
      background = mkLiteral "transparent";
    };
    "#tray" = {
      background = mkLiteral "shade(alpha(${base00}, 0.9), 1);"
    };
    tooltip = {
      background = mkLiteral "${base01}";
      border-radius = mkLiteral "5px";
      border-width = mkLiteral "2px";
      border-style = mkLiteral "solid";
      border-color = mkLiteral "${base07}"; 
    };
    "#network,
    #clock,
    #battery,
    #pulseaudio,
    #workspaces,
    #backlight,
    #memory,
    #tray,
    #window" = {
      padding = mkLiteral "4px 10px";
      background = mkLiteral "shade(alpha(${base00}, 0.9), 1)";
      text-shadow = mkLiteral "1px 1px 2px rgba(0,0,0,0.377)";
      color = mkLiteral "${base05}";
      margin-top = mkLiteral "10px";
      margin-bottom = mkLiteral "5px";
      margin-left = mkLiteral "5px";
      margin-right = mkLiteral "5px";
      box-shadow = mkLiteral "1px 2px 2px #101010";
      border-radius = mkLiteral "10px";
    };
    "#workspaces" = {
      margin-left = mkLiteral "15px";
      font-size = mkLiteral "0px";
      padding = mkLiteral "6px 3px";
      border-radius = mkLiteral "20px";
    };

    "#workspaces button" = {
      font-size = mkLiteral "0px";
      background-color = mkLiteral "${base07}";
      padding = mkLiteral "0px 1px";
      margin = mkLiteral "0px 4px";
      border-radius = mkLiteral "20px";
      transition = mkLiteral "all 0.25s cubic-bezier(0.55, -0.68, 0.48, 1.682)";
    };

    "#workspaces button.active" = {
      font-size = mkLiteral "1px";
      background-color = mkLiteral "${base0E}";
      border-radius = mkLiteral "20px";
      min-width = mkLiteral "30px";
      background-size = mkLiteral "400% 400%";
    };

    "#workspaces button.empty" = {
      font-size = mkLiteral "1px";
      background-color = mkLiteral "${base04}";
    };

    "#window" = {
      color = mkLiteral "${base00}";
      background = mkLiteral "radial-gradient(circle, ${base05} 0%, ${base07} 100%)";
      background-size = mkLiteral "400% 400%";
      animation = mkLiteral "gradient-f 40s ease-in-out infinte";
      transition = mkLiteral "all 0.3s cubic-bezier(0.55, -0.68, 0.48, 1.682)";
    };

    "window#waybar.empty #window" = {
      background = mkLiteral "none";
      background-color = mkLiteral "transparent";
      box-shadow = mkLiteral "none";
    };

    "#battery" = {
      margin-right = mkLiteral "15px";
      background = mkLiteral "linear-gradient(
        118deg,
        ${base0B} 5%,
        ${base0F} 5%,
        ${base0F} 20%,
        ${base0B} 20%,
        ${base0B} 40%,
        ${base0F} 40%,
        ${base0F} 60%,
        ${base0B} 60%,
        ${base0B} 80%,
        ${base0F} 80%,
        ${base0F} 95%,
        ${base0B} 95%
      )";
      background-size = mkLiteral "200% 300%";
      animation = mkLiteral "gradient_f_nh 4s linear infinite";
      color = mkLiteral "${base01}";
    };

    "#battery.charging,
    #battery.plugged" = {
      background = mkLiteral "linear-gradient(
        118deg,
        ${base0E} 5%,
        ${base0D} 5%,
        ${base0D} 20%,
        ${base0E} 20%,
        ${base0E} 40%,
        ${base0D} 40%,
        ${base0D} 60%,
        ${base0E} 60%,
        ${base0E} 80%,
        ${base0D} 80%,
        ${base0D} 95%,
        ${base0E} 95%     
      )";
      background-size = mkLiteral "200% 300%";
      animation = mkLiteral "gradient_rv 4s linear infinite"
    };

    "#battery.full" =  {
      background = mkLiteral "linear-gradient(
        118deg,
        ${base0E} 5%,
        ${base0D} 5%,
        ${base0D} 20%,
        ${base0E} 20%,
        ${base0E} 40%,
        ${base0D} 40%,
        ${base0D} 60%,
        ${base0E} 60%,
        ${base0E} 80%,
        ${base0D} 80%,
        ${base0D} 95%,
        ${base0E} 95%
      )";
      background-size = mkLiteral "200% 300%";
      animation = mkLiteral "gradient_rv 20s linear infinite";
    };

    "#tray > .passive" =  {
      "-gtk-icon-effect" = mkLiteral "dim";
    };

    "#tray > .needs-attention" = {
      "-gtk-icon-effect" = mkLiteral "highlight";
    };
  };
}