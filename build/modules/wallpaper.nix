{ lib, ...  }:

{
  options.wallpaper = lib.mkOption {
    type = lib.types.submodule {
      options = {
        normal = lib.mkOption {
          type = lib.types.path;
          description = "Path to the normal wallpaper image.";
        };

        blurred = lib.mkOption {
          type = lib.types.path;
          description = "Path to the blurred wallpaper image.";
        };
      };
    };
    default = {};
    description = "Wallpaper configuration.";
  };
}