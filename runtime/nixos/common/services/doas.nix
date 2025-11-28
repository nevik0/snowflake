{ username, ... }: 

{
  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          users = [username];
          noPass = true;
          keepEnv = true;
        }
      ];
    };
    sudo = {
      enable = true;
      extraRules = [
        {
          users = [username];
          commands = [
            {
              command = "ALL";
              options = ["NOPASSWD"];
            }
          ];
        }
      ];
      wheelNeedsPassword = false;
    };
  };
}