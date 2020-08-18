{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.shell-environments;
  makeDevEnv = pkgs.callPackage ../../pkgs/build-support/makeDevEnv { };
in {

  options.programs.shell-environments = {
    base = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ coreutils gnugrep gnused gawk ];
      description = "Packages included in EVERY environment.";
    };

    environments = mkOption {
      type = with types;
        listOf (submodule {
          options = {
            name = mkOption { type = str; };
            extraPackages = mkOption {
              type = listOf package;
              default = [ ];
            };
            bashrc = mkOption {
              type = str;
              default = "";
            };
            include = mkOption {
              type = listOf str;
              default = [ ];
            };
          };
        });
      default = [ ];
      example = ''
        [{
          name = "fluff";
          extraPackages = with pkgs; [ neofetch cmatrix sl ];
          include = [ "base-editors" ];
        }]
      '';
      description = "The environments to create shortcuts for.";
    };
  };

  config = let
    setEnv = { name, extraPackages, bashrc, include }:
      makeDevEnv {
        inherit name;
        packages = cfg.base ++ extraPackages;
      };
  in { environment.systemPackages = map setEnv cfg.environments; };
}
