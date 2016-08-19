It's a RESTful service responsible send email for specifics clients.

In this application, there is an embedded application server and a database.

This application is running under Ruby on Rails.


## Used Technologies

**1. Rails 4.2.5.1.**

**2. Ruby 2.0.0.**

**3. Mysql.**

## Additional Technologies

**Database:** Msyql for store both the messages received and sent. The data into send_email_test will be deleted after the tests. The seed.rb it is responsible the initial load in both development and production environment.

**Tests:** The tests are defined as use case of the Junit. The tests of rest services have: Spring Web MVC for mock of the web infrastructure; JsonPath e hamcrest are used for access and assertions in the Json content. The tests have been made available in the structure: src/test/java.

## Considerations

## Usage In Local Machine

###### Pré-requisitos
```
1 - Ruby.

2 - Ruby and Rails.

3 - Mysql.

4 - To create 3 environment variables:
  1 - MAILGUN_DOMAIN_NAME (mailgun domain name)
  2 - MAILGUN_KEY (mailgun key)
  3 - SEND_EMAIL_TEST_EMAIL (email to received all you tests emails :) )

5 - For production environment you need to create more 6 environments variables:
  1 - MAILGUN_DOMAIN_NAME_PRODUCTION (mailgun production domain name)
  2 - MAILGUN_KEY_PRODUCTION (mailgun key production key)
  3 - SEND_EMAIL_PRODUCTION (email to received all emails :) )
  4 - CLIENT_HOSTS (client hosts)
  5 - CLIENT_TOKEN (client token)
  6 - CLIENT_NAME (client name)

###### After download the fonts, to install the necessary gems run this follow command:
$ bundle install

###### After run rake create command to configure the database:
$ rake db:create:all

###### After run rake migrate command to configure the database for all environments
rake db:migrate RAILS_ENV="test"
rake db:migrate RAILS_ENV="development"
rake db:migrate RAILS_ENV="production"

###### After rake test in order to test your applications:
$ rake test

###### After rake test in order to test your development environment you need to run the initial load:
rake db:seed

###### To start the application run:
$ rails server

###### For production environment you need to run the seed command for that environment
rake db:seed RAILS_ENV="production"

###### To test the send email service, type it:
curl -i -X POST http://localhost:3000/api/v1/sendEmail -d {\"message\": \"Precido de uma mensagm que funcionaoriu iua pawoirua pworiuaw pero pweoirua wperoiauwe \",\"subject\": \"Site não funciona\",\"sender_email\":\"teste@teste.com\",\"sender_name\": \"tomas maiorino\",\"token\": \"112211\"}
