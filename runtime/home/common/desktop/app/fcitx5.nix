{ pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-gtk
        libsForQt5.fcitx5-qt
        fcitx5-chinese-addons
        fcitx5-rime
        fcitx5-pinyin-moegirl
        fcitx5-pinyin-zhwiki
      ];
      settings = {
        inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "double_pinyin";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "double_pinyin";
        };
      };
      waylandFrontend = true;
    };
  };

  catppuccin.fcitx5.enable = true;
}
