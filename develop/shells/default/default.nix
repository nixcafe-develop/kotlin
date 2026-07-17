{
  inputs,
  pkgs,
  system,
  ...
}:
let
  jdk = pkgs.graalvmPackages.graalvm-ce;
  kotlin = pkgs.kotlin.override { jre = jdk; };
  gradle = pkgs.gradle.override { java = jdk; };
in
pkgs.mkShell {
  packages = [
    jdk
    kotlin
    gradle
  ];

  shellHook = ''
    ${inputs.self.checks.${system}.git-hooks.shellHook}
  '';
  buildInputs = inputs.self.checks.${system}.git-hooks.enabledPackages;
}
