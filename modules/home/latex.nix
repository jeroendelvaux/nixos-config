{ config, lib, pkgs, secrets, ... }:
let
  mylatex = pkgs.texliveBasic.withPackages (ps: with ps; [
    algorithm2e
    amsmath
    booktabs
    caption
    cleveref
    etoolbox
    geometry
    hyperref
    ifoddpage
    latexmk
    mathtools
    pgfplots
    relsize
    xcolor
  ]);
in
{
  options.latex.enable = lib.mkEnableOption "Enable latex";

  config = lib.mkIf config.latex.enable {
    home.packages = with pkgs; [
      mylatex
    ];
  };
}
