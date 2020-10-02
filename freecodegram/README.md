You can use laravel for auth 
laravel ships with a php server

Blade is a rendering template with PHP snippets
then you can use HTML markups

Laravel has a full dev framework
Laravel ships with working implementation of bootstrap and vue.js

You have to run a compilation
like npm
package manager for javascript

frontend
js vue html

backend
php
laravel


commands

1. composer require laravel/ui
///allows us to login and register
2. php artisan ui vue --auth

3. npm install && npm run dev

npm install
///you must recompile every time there is a change to the frontend
//compile it to smallest file
    npm run dev


PHP migrations
file that describe your database
a file that holds all the instructions of your database to create itself



Create a flat file
setup 
SQLite database


    php artisan migrate

when you make changes to .env file, you have to stop php artisan process


For HTML validation
makes POST back to server  
then server validates data
and then it comes back to us
and the fields are required

Controllers is where the PHP logic is contained
User get created in the Register controller


Whenever you make changes to your database you must run 
php artisan migrate:fresh
//drops all the tables and creates the database from scratch


Now we are making a new controller
php artisan make:controller

Next step is making a new model
make:model represents a table in our database, each object is a row
each user will have a row

php artisan help make:model
eloquent: database framework
