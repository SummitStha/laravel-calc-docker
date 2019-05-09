docker exec -it calcserver composer install
docker exec -it calcserver php artisan migrate
docker exec -it calcserver chmod -R 777 storage
docker exec -it calcserver php artisan storage:link
