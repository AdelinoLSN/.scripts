alias xvia_functions="code ~/.scripts/xvia/gsfunctions.sh"

# #!/bin/bash

#!/bin/bash

# cd android && ./gradlew clean && ./gradlew app:dependencies && ./gradlew app:assembleRelease

export_apk() {
  # set -e

  RUN_BUILD=false

  # Verifica argumentos
  for arg in "$@"; do
    if [ "$arg" = "--build" ]; then
      RUN_BUILD=true
    fi
  done

  APK_PATH="android/app/build/outputs/apk/release/app-release.apk"
  DRIVE_DIR="/Users/adelino/Google Drive/Meu Drive/APKs"

  echo "Atualizando repositório (git pull)..."
  git pull

  if [ "$RUN_BUILD" = true ]; then
    echo "Executando build do APK..."
    (cd android && ./gradlew clean && ./gradlew app:dependencies && ./gradlew app:assembleRelease)
  fi

  if [ ! -f "$APK_PATH" ]; then
    echo "APK não encontrado em: $APK_PATH"
    echo "Use --build para gerar o APK."
    return 1
  fi

  # Timestamp completo
  TS=$(date +"%Y%m%d-%H%M%S")

  TARGET="$DRIVE_DIR/qa-${TS}.apk"

  echo "Copiando para: $TARGET"
  cp "$APK_PATH" "$TARGET"

  echo "Concluído: $TARGET"

  # Abre o local do arquivo no Finder
  open -R "$TARGET"
}


# export_apk() {
#   set -e

#   RUN_BUILD=false

#   # Verifica argumentos
#   for arg in "$@"; do
#     if [ "$arg" = "--build" ]; then
#       RUN_BUILD=true
#     fi
#   done

#   APK_PATH="android/app/build/outputs/apk/release/app-release.apk"
#   DRIVE_DIR="/Users/adelino/Google Drive/Meu Drive/APKs"

#   if [ "$RUN_BUILD" = true ]; then
#     echo "Executando build do APK..."
#     (cd android && ./gradlew app:assembleRelease)
#   fi

#   if [ ! -f "$APK_PATH" ]; then
#     echo "APK não encontrado em: $APK_PATH"
#     echo "Use --build para gerar o APK."
#     return 1
#   fi

#   DATE=$(date +"%Y%m%d")

#   # Extrai último número do build
#   LAST_Z=$(ls "$DRIVE_DIR"/qa-"$DATE"-build*.apk 2>/dev/null \
#     | sed -E 's/.*build([0-9]+)-.*/\1/' \
#     | sort -n \
#     | tail -1)

#   # Garante que LAST_Z seja número
#   if [[ "$LAST_Z" =~ ^[0-9]+$ ]]; then
#     Z=$((LAST_Z + 1))
#   else
#     Z=1
#   fi

#   # 4 caracteres aleatórios (A-Za-z0-9)
#   RAND=$(LC_ALL=C tr -dc 'A-Z' </dev/urandom | head -c 4)

#   # Adicionando prefixo alsn
#   TARGET="$DRIVE_DIR/qa-${DATE}-build${Z}-ALSN${RAND}.apk"

#   echo "Copiando para: $TARGET"
#   cp "$APK_PATH" "$TARGET"

#   echo "Concluído: $TARGET"

#   # Abre o local do arquivo no Finder
#   open -R "$TARGET"
# }
