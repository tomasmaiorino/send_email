package controllers;

import models.Message;
import play.libs.Json;
import play.mvc.Result;

import com.fasterxml.jackson.databind.JsonNode;

public class SendMessage extends Application {
	
	public static Result sendEmail() {
		JsonNode json = request().body().asJson();
	    if(json == null) {
	        return badRequest("Expecting Json data");
	    }
		// read the JsonNode as a Person
		Message message = Json.fromJson(json, Message.class);
        return ok("It works!");
    }
}
