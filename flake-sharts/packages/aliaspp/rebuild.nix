{ stdenvNoCC }:

stdenvNoCC.mkDerivation {
  pname = "rebuild";
  version = "1.0";
  nobuild = true;
  src = ./bash;
  installPhase = ''
    mkdir -p $out/bin
    cp $src/rebuild.sh $out/bin/rebuild
  '';
}
