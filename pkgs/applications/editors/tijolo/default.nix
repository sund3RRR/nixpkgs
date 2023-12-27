{ stdenv
, lib
, fetchFromGitHub
, crystal
, vte-gtk4
, gtksourceview5
, wrapGAppsHook4
, desktopToDarwinBundle
, gi-crystal
, pango
, harfbuzz
, libadwaita
, gobject-introspection
, libxml2
}:
crystal.buildCrystalPackage rec {
  pname = "tijolo";
  version = "0.8.0-alpha";

  src = fetchFromGitHub {
    owner = "hugopl";
    repo = "tijolo";
    rev = "848b90e5e6071c2023aac91e9767d409a8f2dee6";
    hash = "sha256-mv8EuKSrxMkf32ZK9th2K7XBsBHrSXsmsJGI9lv/N3Y=";
  };

  nativeBuildInputs = [
    wrapGAppsHook4
    gi-crystal
    gobject-introspection
    libxml2
  ] ++ lib.optionals stdenv.isDarwin [ desktopToDarwinBundle ];

  buildInputs = [
    libadwaita
    vte-gtk4
    gtksourceview5
    harfbuzz
    pango
    gtksourceview5
  ];

  shardsFile = ./shards.nix;

  buildPhase = ''
    runHook preBuild

    gi-crystal
    shards build --release -s

    runHook postBuild
  '';
  doCheck = false;

  installTargets = [ "install" "install-fonts" "post-install" ];
  doInstallCheck = false;

  meta = with lib; {
    description = "Lightweight, keyboard-oriented IDE for the masses";
    homepage = "https://github.com/hugopl/tijolo";
    license = licenses.mit;
    mainProgram = "tijolo";
    maintainers = with maintainers; [ sund3RRR ];
  };
}
