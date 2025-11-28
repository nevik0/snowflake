{ lib, pkgs, ... }:

{
  home.activation = {
    niri-transition =
      lib.hm.dag.entryAfter [ "writeBoundary" ]
        # bash
        ''
          run ${pkgs.niri-unstable}/bin/niri msg action do-screen-transition
        '';
    reload-swhkd =
      lib.hm.dag.entryAfter [ "niri-transition" ]
        # bash
        ''
          run --quiet ${pkgs.procps}/bin/pkill -HUP swhkd
        '';
  };
}