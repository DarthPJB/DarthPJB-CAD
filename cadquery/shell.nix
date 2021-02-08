{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell
{
  buildInputs = [ pkgs.python37 pkgs.python37Packages.cadquery pkgs.fstl];
  shellHook = ''
     ./task.sh;
     exit;
  '';
}
