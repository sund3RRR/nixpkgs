{ lib
, fetchFromGitHub
, flutter
, cacert
, pkg-config
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
  nativeBuildInputs = [ cacert pkg-config ];
  buildInputs = [ cacert ];

  # dartCompileFlags = [ "--root-certs-file=${cacert}/etc/ssl/certs/ca-bundle.crt" ];

  # pubGetScript = ''
  #   SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt" flutter pub get
  # '';

  # depsListFile = ./deps.json;
  #pubspecLockFile = ./pubspec.lock;
  vendorHash = lib.fakeHash;
}
