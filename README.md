# Simple Restfull API using Ruby on Rails

This simple app using Ruby language and Ruby on Rails framework.


## Need to prepare :

* Ruby version >= 2.5.1
* Ruby on Rails version >= 5.2.3
* MySql

## How to run :

* Clone this repo

* run `bundle install` to install all dependency

* create a database, then setting `config/database.yml` with your database configuration (database, username, password)

* run `rails db:migrate` to migrate all DB schema

* run `rails server` to fire up application

## Available API list :

* `/api/signup`  ---> use to signup to app and create account  
params :  
`username`     
`email`      
`password`     
`password_confirmation`      

* `/api/auth/login` ---> use to login into app, and get bearer token   
params :    
`email`  
`password`   

* No logout API, because it use JWT token. JWT token is save on client side, to logout just delete the token. And then user not have permission to the below API.

* `api/topup`  ---> use to topup balance of user    
header :     
`Authorization`   (Bearer xxxx) get bearer token from `/api/auth/login` response     
`Content-Type`   (multipart/form-data)        
params :    
`email`      
`nominal`     
`activity`     
`type`     
`user_agent`         

* `api/transfer`  ---> use to transfer balance to other user     
header :     
`Authorization`   (Bearer xxxx) get bearer token from `/api/auth/login` response     
`Content-Type`   (multipart/form-data)        
params :    
`sender` (email sender user)     
`receiver` (email receiver user)    
`nominal`     
`activity`     
`user_agent`     

* `api/purchase`  ---> use when user want to purchase something and balance will decrease     
header :     
`Authorization`   (Bearer xxxx) get bearer token from `/api/auth/login` response     
`Content-Type`   (multipart/form-data)        
params :      
`email`       
`nominal`      
`activity`      
`user_agent`       



To hit and test the API you can use [Insomina](https://insomnia.rest/) or [Postman](https://www.postman.com/)
