## EPlus Grading System

### Tested Environment

* Ruby MRI ruby-2.0.0-p247

* Rails 4.0

* Mysql

* Puma

### Installing

	git clone git@github.com:youanden/eplus.git
    
    cd eplus
    
    bundle

### Configuration

#### Mysql Database Creation 

	CREATE DATABASE app_db_dev
  	DEFAULT CHARACTER SET utf8
  	DEFAULT COLLATE utf8_general_ci;

*(preferable if your model data will contain non-latin characters)*

#### Admin Creation

Either use the db/seeds.rb to create an admin, or open:

	rails c

	Admin.create! username: 'user', password: 'pass'

Then you can log in once the app has started.


#### Example gists:

[.env:](https://gist.github.com/youanden/6930280)

[config/database.yml](https://gist.github.com/youanden/6930291)

	rake db:migrate

	foreman start
    
or

	bundle exec puma 



### Roadmap

* Further automation with admin time zones and upcoming assignment javascript detection

* Implement Khan Academy Api

