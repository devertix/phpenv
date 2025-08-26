
for v in "8.4" "8.3" "8.2" "8.1";do # "8.0" "7.4" "7.3" "7.2";do
    docker push ghcr.io/devertix/phpenv:$v
done
