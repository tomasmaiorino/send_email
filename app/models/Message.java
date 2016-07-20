package models;

import play.data.validation.Constraints.Required;

public class Message {

	@Required
	public String message;
	
	@Required
	public String subject;
	
	public String senderName;
	
	@Required
	public String senderEmail;
}
