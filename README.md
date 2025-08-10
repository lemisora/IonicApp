# Desarrollo
- Se esperan las siguientes versiones de paquetes:
- NodeJS - 18.19.0
- npm - 10.2.+ (idealmente 10.2.0)
- Angular - 16.2.11
- Ionic - 7
  ### Opcionalmente
  - pnpm - 8+ : para la instalación de paquetes npm en paralelo, no es necesario, pero mejora la experiencia y es compatible con npm

- Si planeas usar Nix o NixOS checa la siguiente sección:
## Nix (devenv y direnv)
- Se usa devenv para configurar automáticamente el entorno de desarrollo si usas Nix en tu sistema, a modo de facilitar la reproducibilidad y la automatización
- Se usa direnv para acceder a la shell personalizada una vez entrando al directorio del repositorio, esto se hace automáticamente siempre que exista el archivo '.envrc' en el directorio
- Se configuran automáticamente los paquetes:
  - NodeJS - 18.19.0
  - npm - 10.2.3
  - Angular - 16.2.11
  - Ionic - 7.2.1
  - pnpm - 8.14.0
