It's a RESTful service responsible send email for specifics clients.

In this application, there is an embedded application server and a database.

This application is running under Spring Boot.


## Used Technologies

**1. Rails 4.2.5.1.**

**2. Ruby 2.0.0.**

**3. Mysql.**

## Additional Technologies

**Database:** Msyql for store both the messages received and sent. For now, the database needs to created manually. We're using send_email_test for tests, send_email_development for development and send_email for production. The data into send_email_test will be deleted after the tests. The seed.rb it is responsible the initial load in both development and production environment.

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



###### After download the fonts, to install the application and test it execute the maven command:
$ mvn clean install

###### To only test the application execute the maven command:
$ mvn clean test

###### To run the application the maven command:
$ mvn spring-boot:run

###### To test the find products by id, open the browser of your preference and type it:
http://localhost:8080/product/1

###### To test the find products by catalog service, open the browser of your preference and type it:
http://localhost:8080/product/cat/Store

###### To test find list service by id service, open the browser of your preference and type it:
http://localhost:8080/order/1

###### To test the find orders by sku id service, open the browser of your preference and type it:
http://localhost:8080/order/sku/1

###### To test the find all orders service, open the browser of your preference and type it:
http://localhost:8080/order/all

###### To test the create order service, tpye it:
curl -i -H "Content-Type:application/json" -H "Accept:application/json" -X POST http://localhost:8080/order -d "{\"commerceItems\": [{\"sku\": {\"id\": 3},\"quantity\": 12,\"unitValue\": 12}],\"status\": \"SUBMITTED\",\"paymentStatus\": \"CREATED\",\"totalAmount\": 26}

##### To update the order, type it:
curl -i -H "Content-Type:application/json" -H "Accept:application/json" -X PUT -d "{\"id\":4, \"commerceItems\": [{\"sku\": {\"id\": 1},\"quantity\": 12,\"unitValue\": 12}],\"status\": \"APPROVED\",\"paymentStatus\": \"CREATED\",\"totalAmount\": 21}" http://localhost:8080/order
