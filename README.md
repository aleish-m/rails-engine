# README - Rails Engine API

## Info
 This project was created to give users access to several different API endpoints relating to Merchants, Items, and items owned by a specific Merchant.

## About the Project
The API supports relationships between Merchants and Items, allowing you to grab a certain Items Merchant or a Merchants Items. The full rundown of API endpoints will be located below in endpoints

This API also has a front facing application that consumes it. That is located [here](https://github.com/aleish-m/rails_engine_fe)

## Built With
![RoR](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![pgsql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

## Gems
![rspec](https://img.shields.io/gem/v/rspec-rails?label=rspec&style=flat-square)
![shoulda](https://img.shields.io/gem/v/shoulda-matchers?label=shoulda-matchers&style=flat-square)
![simplecov](https://img.shields.io/gem/v/simplecov?label=simplecov&style=flat-square)
![spring](https://img.shields.io/gem/v/spring?color=blue&label=spring)
![faker](https://img.shields.io/gem/v/faker?color=blue&label=faker)
![factory bot](https://img.shields.io/gem/v/factory_bot_rails?color=blue&label=factory_bot_rails)
![pry](https://img.shields.io/gem/v/pry?color=blue&label=pry)

## Set Up
- Clone this repo
  - `bundle install`
  - `rails s`
- Database set up
  - `rails db:{create,migrate,seed}`
  - `rails db:schema:dump`

Visit the [front-end application](https://github.com/aleish-m/rails_engine_fe) to begin front-end setup.

## Deployment
- In terminal (apple or integrated)
    * `rails s`
- Navigate to desired API endpoint as noted below

## Running Test Suite Instructions

- Clone this repo
- In terminal (apple or integrated)
    * `bundle install`
    * `rails db:{create,migrate,seed}`
    * `rails db:schema:dump`
    * `bundle exec rspec`

## Database Structure

![image](https://user-images.githubusercontent.com/105686836/199165142-119b99f8-4920-4eb5-9733-ed8bf6908523.png)

## End Points

### Merchants

**Get all Merchants**

GET `http://localhost:3000/api/v1/merchants`

**Get one Merchant**

GET `http://localhost:3000/api/v1/merchants/<merchant_id>`

**Get all Merchant Items**

GET `http://localhost:3000/api/v1/merchants/<merchant_id>/items`

### Items

**Get all Items**

GET `http://localhost:3000/api/v1/items`

**Get one Item**

GET `http://localhost:3000/api/v1/items/<item_id>`

**Create/Delete Item**

POST/DELETE `http://localhost:3000/api/v1/items`

**Update Item**

PUT `http://localhost:3000/api/v1/items/<item_id>`

**Get Item's Merchant**

GET `http://localhost:3000/api/v1/items/<item_id>/merchant`

### Search Options

**Find Merchant by Name Fragment**

GET `http://localhost:3000/api/v1/merchants/find?name=<fragment>`

**Find all Items by Name Fragment**

GET `http://localhost:3000/api/v1/items/find_all?name=<fragment>`

**Find all Items by Min/Max Price**

GET `http://localhost:3000/api/v1/items/find_all?min_price=<price>&max_price=<price>`

## Contributors
<p><a href="https://github.com/aleish-m/rails-engine/graphs/contributors">
<img src="https://contrib.rocks/image?repo=aleish-m/rails-engine" />
</a></p>

**Github:** <https://github.com/aleish-m/>  
**LinkedIn:** <https://www.linkedin.com/in/aleisha-mork/>
