{ inputs }:
final: _prev: 
import ../packages {
  inherit inputs; 
  pkgs = final; 
}