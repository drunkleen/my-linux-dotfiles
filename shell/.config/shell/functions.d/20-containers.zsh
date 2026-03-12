dockerstart() {
  printf '%s%s Starting Docker%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_DOCKER" "$_SHELL_UI_RESET"
  sudo systemctl start docker
}

dockerstop() {
  printf '%s%s Stopping Docker%s\n' "$_SHELL_UI_YELLOW" "$_SHELL_ICON_DOCKER" "$_SHELL_UI_RESET"
  sudo systemctl stop docker.socket
  sudo systemctl stop docker.service
}

dockerlist() {
  printf '%s%s Running containers%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_DOCKER" "$_SHELL_UI_RESET"
  sudo docker container ls
}

pgstart() {
  local pg_container="${PG_CONTAINER_NAME:-postgresql}"
  local pg_image="${PG_CONTAINER_IMAGE:-postgres:16-alpine}"
  local pg_user="${PG_USER:-pguser}"
  local pg_password="${PG_PASSWORD:-pgpass}"
  local pg_db="${PG_DATABASE:-postgres}"
  local pg_port="${PG_PORT:-5432}"
  local pgadmin_container="${PGADMIN_CONTAINER_NAME:-pgAdmin}"
  local pgadmin_image="${PGADMIN_CONTAINER_IMAGE:-dpage/pgadmin4:latest}"
  local pgadmin_email="${PGADMIN_DEFAULT_EMAIL:-admin@hogwarts.local}"
  local pgadmin_password="${PGADMIN_DEFAULT_PASSWORD:-admin}"
  local pgadmin_port="${PGADMIN_PORT:-8081}"
  local ip pgadmin_ip

  printf '%s%s Starting PostgreSQL stack%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_DB" "$_SHELL_UI_RESET"

  if ! sudo docker container inspect "$pg_container" >/dev/null 2>&1; then
    printf '%s%s Creating container:%s %s\n' "$_SHELL_UI_CYAN" "$_SHELL_ICON_INFO" "$_SHELL_UI_RESET" "$pg_container"
    sudo docker run -d \
      --name "$pg_container" \
      -e POSTGRES_USER="$pg_user" \
      -e POSTGRES_PASSWORD="$pg_password" \
      -e POSTGRES_DB="$pg_db" \
      -p "${pg_port}:5432" \
      "$pg_image" >/dev/null || return 1
  else
    sudo docker start "$pg_container" >/dev/null || return 1
  fi

  if ! sudo docker container inspect "$pgadmin_container" >/dev/null 2>&1; then
    printf '%s%s Creating container:%s %s\n' "$_SHELL_UI_CYAN" "$_SHELL_ICON_INFO" "$_SHELL_UI_RESET" "$pgadmin_container"
    sudo docker run -d \
      --name "$pgadmin_container" \
      -e PGADMIN_DEFAULT_EMAIL="$pgadmin_email" \
      -e PGADMIN_DEFAULT_PASSWORD="$pgadmin_password" \
      -p "${pgadmin_port}:80" \
      "$pgadmin_image" >/dev/null || return 1
  else
    sudo docker start "$pgadmin_container" >/dev/null || return 1
  fi

  ip="$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$pg_container" 2>/dev/null)"
  pgadmin_ip="$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$pgadmin_container" 2>/dev/null)"

  printf '%s%s PostgreSQL:%s postgres://%s:%s@127.0.0.1:%s/%s\n' "$_SHELL_UI_GREEN" "$_SHELL_ICON_OK" "$_SHELL_UI_RESET" "$pg_user" "$pg_password" "$pg_port" "$pg_db"
  [[ -n "$ip" ]] && printf '  %scontainer ip%s  %s\n' "$_SHELL_UI_DIM" "$_SHELL_UI_RESET" "$ip"
  printf '%s%s pgAdmin:%s http://127.0.0.1:%s\n' "$_SHELL_UI_GREEN" "$_SHELL_ICON_OK" "$_SHELL_UI_RESET" "$pgadmin_port"
  [[ -n "$pgadmin_ip" ]] && printf '  %scontainer ip%s  %s\n' "$_SHELL_UI_DIM" "$_SHELL_UI_RESET" "$pgadmin_ip"
}

pgstop() {
  local pg_container="${PG_CONTAINER_NAME:-postgresql}"
  local pgadmin_container="${PGADMIN_CONTAINER_NAME:-pgAdmin}"
  printf '%s%s Stopping PostgreSQL stack%s\n' "$_SHELL_UI_YELLOW" "$_SHELL_ICON_DB" "$_SHELL_UI_RESET"
  sudo docker container inspect "$pg_container" >/dev/null 2>&1 && sudo docker stop "$pg_container" >/dev/null
  sudo docker container inspect "$pgadmin_container" >/dev/null 2>&1 && sudo docker stop "$pgadmin_container" >/dev/null
}

mongostart() {
  local mongo_container="${MONGO_CONTAINER_NAME:-mongodb}"
  local mongo_image="${MONGO_CONTAINER_IMAGE:-mongo:7}"
  local mongo_port="${MONGO_PORT:-27017}"

  printf '%s%s Starting MongoDB%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_DB" "$_SHELL_UI_RESET"
  if ! sudo docker container inspect "$mongo_container" >/dev/null 2>&1; then
    printf '%s%s Creating container:%s %s\n' "$_SHELL_UI_CYAN" "$_SHELL_ICON_INFO" "$_SHELL_UI_RESET" "$mongo_container"
    sudo docker run -d \
      --name "$mongo_container" \
      -p "${mongo_port}:27017" \
      "$mongo_image" >/dev/null || return 1
  else
    sudo docker start "$mongo_container" >/dev/null || return 1
  fi
  printf '%s%s MongoDB:%s mongodb://127.0.0.1:%s\n' "$_SHELL_UI_GREEN" "$_SHELL_ICON_OK" "$_SHELL_UI_RESET" "$mongo_port"
}

mongostop() {
  local mongo_container="${MONGO_CONTAINER_NAME:-mongodb}"
  printf '%s%s Stopping MongoDB%s\n' "$_SHELL_UI_YELLOW" "$_SHELL_ICON_DB" "$_SHELL_UI_RESET"
  sudo docker container inspect "$mongo_container" >/dev/null 2>&1 && sudo docker stop "$mongo_container" >/dev/null
}

searxstart() {
  local searx_container="${SEARX_CONTAINER_NAME:-searx}"
  local searx_image="${SEARX_CONTAINER_IMAGE:-searxng/searxng:latest}"
  local searx_port="${SEARX_PORT:-8080}"

  printf '%s%s Starting SearX%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_DOCKER" "$_SHELL_UI_RESET"
  if ! sudo docker container inspect "$searx_container" >/dev/null 2>&1; then
    printf '%s%s Creating container:%s %s\n' "$_SHELL_UI_CYAN" "$_SHELL_ICON_INFO" "$_SHELL_UI_RESET" "$searx_container"
    sudo docker run -d \
      --name "$searx_container" \
      -p "${searx_port}:8080" \
      "$searx_image" >/dev/null || return 1
  else
    sudo docker start "$searx_container" >/dev/null || return 1
  fi
  printf '%s%s SearX:%s http://127.0.0.1:%s\n' "$_SHELL_UI_GREEN" "$_SHELL_ICON_OK" "$_SHELL_UI_RESET" "$searx_port"
}

searxstop() {
  local searx_container="${SEARX_CONTAINER_NAME:-searx}"
  printf '%s%s Stopping SearX%s\n' "$_SHELL_UI_YELLOW" "$_SHELL_ICON_DOCKER" "$_SHELL_UI_RESET"
  sudo docker container inspect "$searx_container" >/dev/null 2>&1 && sudo docker stop "$searx_container" >/dev/null
}

redisstart() {
  local redis_container="${REDIS_CONTAINER_NAME:-redis}"
  local redis_image="${REDIS_CONTAINER_IMAGE:-redis:7-alpine}"
  local redis_port="${REDIS_PORT:-6379}"
  printf '%s%s Starting Redis%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_DB" "$_SHELL_UI_RESET"
  if ! sudo docker container inspect "$redis_container" >/dev/null 2>&1; then
    printf '%s%s Creating container:%s %s\n' "$_SHELL_UI_CYAN" "$_SHELL_ICON_INFO" "$_SHELL_UI_RESET" "$redis_container"
    sudo docker run -d \
      --name "$redis_container" \
      -p "${redis_port}:6379" \
      "$redis_image" >/dev/null || return 1
  else
    sudo docker start "$redis_container" >/dev/null || return 1
  fi

  local ip
  ip="$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$redis_container" 2>/dev/null)"
  printf '%s%s Redis:%s redis://127.0.0.1:%s\n' "$_SHELL_UI_GREEN" "$_SHELL_ICON_OK" "$_SHELL_UI_RESET" "$redis_port"
  [[ -n "$ip" ]] && printf '  %scontainer ip%s  %s\n' "$_SHELL_UI_DIM" "$_SHELL_UI_RESET" "$ip"
}

redisstop() {
  local redis_container="${REDIS_CONTAINER_NAME:-redis}"
  printf '%s%s Stopping Redis%s\n' "$_SHELL_UI_YELLOW" "$_SHELL_ICON_DB" "$_SHELL_UI_RESET"
  sudo docker container inspect "$redis_container" >/dev/null 2>&1 && sudo docker stop "$redis_container" >/dev/null
}
