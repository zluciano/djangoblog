HOST=joseluciano.busercamp.com.br

function devhelp() {
    echo "dkbuild  constroi a imagem docker"
    echo "dkrun  roda o projeto dockerizado"
    echo "deploy  da deploy"
}

function dkbuild() {
    docker build -t joseluciano .
}

function dkrun() {
     docker run -it -p 8002:8000 \
      -e DATABASE_FILE=/dkdata/db.sqlite3 \
      -e DJANGO_STATIC_ROOT=/dkdata/static \
      -v $(pwd)/dkdata:/dkdata \
      joseluciano start.sh
}

function deploy() {
    rsync -av --exclude dkdata --exclude db.sqlite3 \
    ./* ubuntu@$HOST:./joseluciano/
    ssh ubuntu@$HOST "cd joseluciano && ./dkrunprod.sh"
}
devhelp
