ENV_FILE=".env"

if test -f "$ENV_FILE"; then
  export "$(grep -v '^#' .env | xargs -d '\n')"
fi
echo "DONE"