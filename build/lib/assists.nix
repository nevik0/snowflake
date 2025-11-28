{ nevik }:
let 
  inherit (nevik.nixpkgs) pipe;
in 
rec {
  invoke = cond: file: if cond && (builtins.pathExists file) then [ file ] else [ ];
  invoke' = file: invoke true file;

  mkGLColor = { config }: color: let
    inherit (config.lib.stylix) colors;
    r = colors."${color}-rgb-r";
    g = colors."${color}-rgb-g";
    b = colors."${color}-rgb-b";
    rf = "${r}.0 / 255.0";
    gf = "${g}.0 / 255.0";
    bf = "${b}.0 / 255.0";
  in 
  "vec4(${rf}, ${gf}, ${bf}, 1.0)";

  mkSwhkdrc = { 
    keyBindings, 
    includes ? [], 
    ignores ? [], 
    modes ? [], 
    extraConfig ? ""
  }:
  let
    mkKeyBinding = { 
      key, 
      command, 
      onRelease ? false, 
      swallow ? true 
    }: 
    let
      onReleasePrefix = if onRelease then "@" else "";
      swallowPrefix   = if swallow then "" else "~";
    in ''
      ${onReleasePrefix}${swallowPrefix}${key}
          ${command}'';
    mkMode = { 
      name, 
      swallow ? true, 
      oneoff ? false, 
      keyBindings, 
      enterKeys ? [], 
      escapeKeys ? [] 
    }: 
    let
      swallowStr = if swallow then "swallow" else "";
      oneoffStr  = if oneoff  then "oneoff"  else "";
    in
    pipe (map (key: mkKeyBinding {
      inherit key;
      command = "notify-send 'entering mode ${name}' && @enter ${name}";
    }) enterKeys) [ (builtins.concatStringsSep "\n") ]
    + "\n"
    + "mode ${name} ${swallowStr} ${oneoffStr}\n"
    + pipe (map mkKeyBinding keyBindings) [ (builtins.concatStringsSep "\n") ]
    + "\n"
    + pipe (map (key: mkKeyBinding {
      inherit key;
      command = "notify-send 'exiting mode ${name}' && @escape";
    }) escapeKeys) [ (builtins.concatStringsSep "\n") ]
    + "\nendmode\n";
  in
  pipe 
  (map (f: "include ${f}") includes
  ++ map (k: "ignore ${k}") ignores
  ++ map mkKeyBinding keyBindings
  ++ map mkMode modes
  ) [ (builtins.concatStringsSep "\n") ]
  + extraConfig;

  mkNixSettings = { username, size, ... }: {
    experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];
    keep-outputs = true;
    trusted-users = [ "${username}" ];
    keep-derivations = true;
    auto-optimise-store = true;
    channel.enable = true;
    download-buffer-size = size;
  };
}