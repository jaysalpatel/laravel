cd /app
echo "Provisioning laravel"

dirs=("/freecodegram/app/" "freecodegram/public")






php artisan migrate --force
php artisan clear-compiled
php artisan cache:clear
php artisan view:clear
php artisan route:clear
php artisan config:clear