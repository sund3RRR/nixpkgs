{ lib
, fetchFromGitHub
, flutter
, cmake
, mimalloc
, clang
, removeReferencesTo
}:
flutter.buildFlutterApplication rec {
  pname = "musicpod";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "ubuntu-flutter-community";
    repo = "musicpod";
    rev = "b15605ff822c76c804729d96ae351bbb17215bbb";
    hash = "sha256-mFsiy69xHHCBDAg2RyeSV36/0c0F7UWsw7LnmIMID3k=";
  };

  postInstall = ''
    exit 1
  '';
  buildPhase = ''
    git clone https://github.com/ubuntu-flutter-community/musicpod/tree/main
    exit 1
    dart compile
  '';
  nativeBuildInputs = [
    removeReferencesTo
    flutter
    mimalloc
    cmake
    clang
  ];

  disallowedReferences = [
    flutter
  ];
  autoDepsList = true;
  #depsListFile = ./deps.json;
  pubspecLockFile = ./pubspec.lock;
  vendorHash = "sha256-tAmakxg0wLMed6UOJY6gu2S85fayBzKYWeSA1FReFlw=";
}
