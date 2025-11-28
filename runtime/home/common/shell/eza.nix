# Eza is a ls replacement
{
  catppuccin.eza.enable = true;

  programs.eza = {
    enable = true;
    icons = "auto";

    extraOptions = [
      "--group-directories-first"
      "--no-quotes"
      "--git-ignore"
      "--icons=always"
    ];
  };
}
