package controllers;
import models.EMessage;
import models.Response;
import patch.PatchedForm;
import play.data.Form;
import play.db.ebean.Transactional;
import play.libs.Json;
import play.mvc.Result;

import com.fasterxml.jackson.databind.JsonNode;

public class SendMessage extends Application {
	
    @Transactional
	public static Result sendEmail() {
		JsonNode json = request().body().asJson();
	    if(json == null) {
	        return badRequest("Expecting Json data");
	    }
		Form<EMessage> message = new PatchedForm<EMessage>(EMessage.class).bind(json);
		if (message.hasErrors()) {
			return badRequest(Json.toJson(new Response(message.globalError().message(), BAD_REQUEST)));
		} else {
			message.get().save();
		}
        return ok("It works!");
    }
}
