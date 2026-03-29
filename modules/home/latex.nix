{ config, lib, pkgs, secrets, ... }:
let
  mylatex = pkgs.texliveBasic.withPackages (ps: with ps; [
    amsmath
    etoolbox
    geometry
    hyperref
    latexmk
    pgfplots
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
