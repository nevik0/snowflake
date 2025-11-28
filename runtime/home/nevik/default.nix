{ hostname, pkgs, ... }:

{
  # Import the user configuration on this host;
  imports = [ ./${hostname}.nix ];

  # The user avatar can be displaye in combination with a special bar;
  home.file.".face".source = ./face.jpeg;

  # The user's personal configuration is universal for each host
  programs = {
    git = {
      settings = {
        user = {
          name = "elowenOwO";
          email = "nyxusy@163.com";
        };
        safe.directory = "*";
      };
      enable = true;
    };
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.packages = with pkgs; [
    zip
    mpv
    unzip
    pipes
    cmatrix
    cbonsai
    peaclock
    libreoffice
  ];
}