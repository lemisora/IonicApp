{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  # importa el nixpkgs-unstable que declaraste en devenv.yaml
  unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };

  # la derivación que queremos (esperamos nodejs_18 = 18.19.0 en esa revisión)
  nodeFromUnstable = unstable.nodejs_18;
in
{

  # Variables de entorno
  env = {
    PROJECT_DIR = "./nixy";
  };

  # Ponemos overlay para exponer/forzar nodejs a la versión importada:
  overlays = [
    (final: prev: {
      # Reemplazamos nodejs y exponemos nodejs_18 para evitar confusiones
      nodejs = nodeFromUnstable;
    })
  ];

  packages = with pkgs; [
    git
    openssl
    pnpm
  ];

  languages = {
    javascript = {
      enable = true;

      # indicamos explícitamente el "node" que queremos usar en herramientas JS
      # (por defecto devenv usa pkgs.nodejs-slim; aquí forzamos nodejs_18).
      package = pkgs.nodejs;

      npm = {
        enable = true;
        # el paquete npm por defecto viene con node; si quieres usar
        # un package npm separado podrías poner pkgs.nodePackages.npm
        # package = pkgs.nodejs;
        install.enable = false; # We'll control installs manually below
      };

      pnpm = {
        enable = true;
        package = pkgs.nodePackages.pnpm;
        install.enable = true; # corre pnpm install si hay package.json
      };
    };
  };

  # Script para instalar Angular CLI e Ionic solo cuando quieras
  scripts.setup-dev.exec = ''
    echo "→ Instalando Angular CLI 16.2.11 e Ionic CLI localmente..."
    pnpm add -D @angular/cli@16.2.11 @ionic/cli
    echo "✅ Herramientas instaladas en node_modules/.bin"
  '';

  # Proceso para levantar ionic serve
  processes.ionic-dev.exec = "cd \$PROJECT_DIR && ionic serve";

  enterShell = ''
    echo "🔧 Node: $(node -v) | npm: $(npm -v) | pnpm: $(pnpm -v)"
        export PATH="$PWD/node_modules/.bin:$PATH"
        export NODE_OPTIONS="--openssl-legacy-provider"

        if command -v ng >/dev/null; then
          echo "✅ Angular CLI detectado: $(ng version | head -n 10)"
        else
          echo "⚠️ Angular CLI no instalado. Ejecuta: devenv run setup-dev"
        fi

        if command -v ionic >/dev/null; then
          echo "✅ Ionic CLI detectado: $(ionic --version)"
        else
          echo "⚠️ Ionic CLI no instalado. Ejecuta: devenv run setup-dev"
        fi
  '';

  enterTest = ''
    echo "Test: git: $(git --version)"
  '';
}
