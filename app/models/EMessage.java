package models;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

import play.data.format.Formats;
import play.data.validation.Constraints.Required;
import play.db.ebean.Model;

@Entity
public class EMessage extends Model {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4787460763446465068L;

	@Id
    public Long id;
	
	@Required
	public String message;

	@Required
	public String subject;

	public String senderName;

	@Required
	public String senderEmail;

	@Required
	public String token;
	
	public boolean async;

	@Formats.DateTime(pattern = "dd/MM/yyyy hh:mm:ss")
	public Date creationDate = new Date();

	public Boolean valid = false;
}
