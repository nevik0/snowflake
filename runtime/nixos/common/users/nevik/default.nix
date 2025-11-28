{ 
  config, 
  pkgs, 
  ...
}:
let
  ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users. = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "audio"
      "networkmanager"
      "users"
      "video"
      "wheel"
    ] ++ ifExists [
      "docker"
      "plugdev"
      "render"
      "lxd"
    ];
    openssh.authorizedKeys.keys = [

    ];
    packages = with pkgs; [ kitty home-manager vscode];
    hashedPassword = '''';
  };
  environment.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };
}