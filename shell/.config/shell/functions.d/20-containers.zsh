dockerstart() {
  sudo systemctl start docker
}

dockerstop() {
  sudo systemctl stop docker.socket
  sudo systemctl stop docker.service
}

dockerlist() {
  sudo docker container ls
}

pgstart() {
  sudo docker start postgresql
  sudo docker start pgAdmin

  local ip pgadmin_ip
  ip="$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' postgresql 2>/dev/null)"
  pgadmin_ip="$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' pgAdmin 2>/dev/null)"

  [[ -n "$ip" ]] && echo "PostgreSQL: postgres://pguser:pgpass@${ip}:5432/postgres"
  [[ -n "$pgadmin_ip" ]] && echo "pgAdmin: http://${pgadmin_ip}:80"
}

pgstop() {
  sudo docker stop postgresql
  sudo docker stop pgAdmin
}

mongostart() {
  sudo docker start mongodb
  echo "MongoDB: mongodb://localhost:27017"
}

mongostop() {
  sudo docker stop mongodb
}

searxstart() {
  sudo docker start searx
  echo "SearX: http://127.0.0.1:80"
}

searxstop() {
  sudo docker stop searx
}

redisstart() {
  sudo docker start redis

  local ip
  ip="$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis 2>/dev/null)"
  [[ -n "$ip" ]] && echo "Redis: redis://${ip}:6379"
}

redisstop() {
  sudo docker stop redis
}
