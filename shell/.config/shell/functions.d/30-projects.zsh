initmvn() {
  local name="${1:-}"
  (( $# )) || shell_fail "Usage: initmvn <name>" || return 1
  [[ ! -e "$name" ]] || shell_fail "Directory already exists: $name" || return 1
  shell_need mvn || return 1
  shell_need curl || return 1

  mvn archetype:generate \
    -DgroupId="com.drunkleen.${name}" \
    -DartifactId="${name}" \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DarchetypeVersion=1.5 \
    -DinteractiveMode=false

  touch "./${name}/.env"
  curl -fsSLo "./${name}/.gitignore" https://raw.githubusercontent.com/github/gitignore/refs/heads/main/Maven.gitignore
}

initgo() {
  local name="${1:-}"
  (( $# )) || shell_fail "Usage: initgo <name>" || return 1
  [[ ! -e "$name" ]] || shell_fail "Directory already exists: $name" || return 1
  shell_need go || return 1
  shell_need curl || return 1

  mkdir -p "$name"
  pushd "$name" >/dev/null || return 1

  go mod init "github.com/drunkleen/${name}"
  : > main.go
  : > .env
  curl -fsSLo .gitignore https://raw.githubusercontent.com/github/gitignore/refs/heads/main/community/Golang/Go.AllowList.gitignore

  popd >/dev/null || return 1
}
