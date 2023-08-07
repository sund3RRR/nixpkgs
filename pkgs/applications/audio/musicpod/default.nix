{ lib
, fetchFromGitHub
, flutter
}:
flutter.buildFlutterApplication rec {
  pname = "musicpod";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "ubuntu-flutter-community";
    repo = "musicpod";
    rev = "b15605f";
    hash = "sha256-mFsiy69xHHCBDAg2RyeSV36/0c0F7UWsw7LnmIMID3k=";
  };

  pubGetScript = ''
    flutter pub get
    exit 1
  '';
  autoDepsList = true;
  pubspecLockFile = ./pubspec.lock;
  vendorHash = lib.fakeHash;
}
