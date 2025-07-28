#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

APP_DIR="/var/www/html/SuiteCRM"
ZIP_FILE="/var/www/html/SuiteCRM-8.8.0.zip"
CUSTOM_PHP_DIR="/var/www/html/custom_php"
CUSTOM_PACKAGES_DIR="/var/www/html/custom_packages"
MODULE_DIR="$APP_DIR/public/legacy/upload/upgrades/module"
DOWNLOAD_URL="https://suitecrm.com/download/165/suite88/565090/suitecrm-8-8-0.zip"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

init_suitecrm() {
  log "Initializing SuiteCRM..."

  log "Downloading SuiteCRM from: $DOWNLOAD_URL"
  curl -L -o "$ZIP_FILE" "$DOWNLOAD_URL"
  log "Download completed."

  if [[ -f "$ZIP_FILE" ]]; then
    log "Extracting SuiteCRM from $ZIP_FILE..."
    unzip -q "$ZIP_FILE" -d "$APP_DIR"
    rm "$ZIP_FILE"
    log "SuiteCRM extracted to $APP_DIR."

    # Copy custom PHP overrides
    cp "$CUSTOM_PHP_DIR/InstallHandler.php" \
       "$APP_DIR/core/backend/Install/LegacyHandler/InstallHandler.php"

    cp "$CUSTOM_PHP_DIR/MysqliManager.php" \
       "$APP_DIR/public/legacy/include/database/MysqliManager.php"

    cp "$CUSTOM_PHP_DIR/Driver.php" \
       "$APP_DIR/vendor/doctrine/dbal/src/Driver/PDO/MySQL/Driver.php"

    cp "$CUSTOM_PHP_DIR/CheckDBConnection.php" \
       "$APP_DIR/core/backend/Install/Service/Installation/Steps/CheckDBConnection.php"

    log "Custom PHP files applied."

    # Set permissions
    chown -R www-data:www-data "$APP_DIR"
    find "$APP_DIR" -type d -exec chmod 755 {} \;
    find "$APP_DIR" -type f -exec chmod 644 {} \;

    log "Permissions set for SuiteCRM."

    log "Generating self-signed SSL certificate..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
      -keyout /etc/ssl/private/apache-selfsigned.key \
      -out /etc/ssl/certs/apache-selfsigned.crt \
      -subj "/C=UK/ST=TestSt/L=Test/O=OS/CN=localhost"
  else
    log "❌  ERROR: Failed to download or locate SuiteCRM zip file."
    sleep 3
    exit 1
  fi
}

copy_package_and_extract_manifests() {
  log "Copying packages and extracting manifests..."

  mkdir -p "$MODULE_DIR"
  cp "$CUSTOM_PACKAGES_DIR"/*.zip "$MODULE_DIR/" || true

  for zipfile in "$MODULE_DIR"/*.zip; do
    [[ -e "$zipfile" ]] || continue

    base="$(basename "$zipfile" .zip)"
    manifest_path="$MODULE_DIR/${base}-manifest.php"

    if [[ -f "$manifest_path" ]]; then
      log "✔️  Manifest already exists for $(basename "$zipfile")"
      continue
    fi

    log "📦  Extracting manifest from $(basename "$zipfile")..."
    if unzip -p "$zipfile" manifest.php > "$manifest_path" 2>/dev/null && [[ -s "$manifest_path" ]]; then
      log "✅  Saved manifest as $(basename "$manifest_path")"
    else
      log "❌  Failed to extract manifest.php from $(basename "$zipfile")"
      rm -f "$manifest_path"
    fi
  done
}

main() {
  if [[ ! -d "$APP_DIR" || -z "$(ls -A "$APP_DIR" 2>/dev/null)" ]]; then
    init_suitecrm
  else
    log "SuiteCRM already initialized. Skipping setup."
  fi

  copy_package_and_extract_manifests

  log "Starting Apache server..."
  exec apachectl -D FOREGROUND "$@"
}

main "$@"
