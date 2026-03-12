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
  printf '%s%s Starting PostgreSQL stack%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_DB" "$_SHELL_UI_RESET"
  sudo docker start postgresql
  sudo docker start pgAdmin

  local ip pgadmin_ip
  ip="$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' postgresql 2>/dev/null)"
  pgadmin_ip="$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' pgAdmin 2>/dev/null)"

  [[ -n "$ip" ]] && printf '%s%s PostgreSQL:%s postgres://pguser:pgpass@%s:5432/postgres\n' "$_SHELL_UI_GREEN" "$_SHELL_ICON_OK" "$_SHELL_UI_RESET" "$ip"
  [[ -n "$pgadmin_ip" ]] && printf '%s%s pgAdmin:%s http://%s:80\n' "$_SHELL_UI_GREEN" "$_SHELL_ICON_OK" "$_SHELL_UI_RESET" "$pgadmin_ip"
}

pgstop() {
  printf '%s%s Stopping PostgreSQL stack%s\n' "$_SHELL_UI_YELLOW" "$_SHELL_ICON_DB" "$_SHELL_UI_RESET"
  sudo docker stop postgresql
  sudo docker stop pgAdmin
}

mongostart() {
  printf '%s%s Starting MongoDB%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_DB" "$_SHELL_UI_RESET"
  sudo docker start mongodb
  printf '%s%s MongoDB:%s mongodb://localhost:27017\n' "$_SHELL_UI_GREEN" "$_SHELL_ICON_OK" "$_SHELL_UI_RESET"
}

mongostop() {
  printf '%s%s Stopping MongoDB%s\n' "$_SHELL_UI_YELLOW" "$_SHELL_ICON_DB" "$_SHELL_UI_RESET"
  sudo docker stop mongodb
}

searxstart() {
  printf '%s%s Starting SearX%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_DOCKER" "$_SHELL_UI_RESET"
  sudo docker start searx
  printf '%s%s SearX:%s http://127.0.0.1:80\n' "$_SHELL_UI_GREEN" "$_SHELL_ICON_OK" "$_SHELL_UI_RESET"
}

searxstop() {
  printf '%s%s Stopping SearX%s\n' "$_SHELL_UI_YELLOW" "$_SHELL_ICON_DOCKER" "$_SHELL_UI_RESET"
  sudo docker stop searx
}

redisstart() {
  printf '%s%s Starting Redis%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_DB" "$_SHELL_UI_RESET"
  sudo docker start redis

  local ip
  ip="$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis 2>/dev/null)"
  [[ -n "$ip" ]] && printf '%s%s Redis:%s redis://%s:6379\n' "$_SHELL_UI_GREEN" "$_SHELL_ICON_OK" "$_SHELL_UI_RESET" "$ip"
}

redisstop() {
  printf '%s%s Stopping Redis%s\n' "$_SHELL_UI_YELLOW" "$_SHELL_ICON_DB" "$_SHELL_UI_RESET"
  sudo docker stop redis
}
