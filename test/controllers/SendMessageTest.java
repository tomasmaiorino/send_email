package controllers;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static play.mvc.Http.Status.OK;
import static play.test.Helpers.contentAsString;

import org.junit.Test;

import play.mvc.Result;
import play.test.WithApplication;

public class SendMessageTest extends WithApplication {
	  public static final String MOCK_MESSAGE = "{  \"message\": \"Mensagem\",  \"subject\": \"duvida\",  \"senderEmail\": \"teste@teste.com\"}";

	  @Test
	  public void testIndex() {
	    Result result = new SendMessage().sendEmail();
	    assertEquals(OK, result);
	    //assertEquals("text/html", result.contentType().get());
	    //assertEquals("utf-8", result.charset().get());
	    assertTrue(contentAsString(result).contains("Welcome"));
	  }

}
