package models;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

import play.data.format.Formats;
import play.data.validation.Constraints.Required;
import play.db.ebean.Model;

@Entity
public class SentEMessage extends Model {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
    public Long id;

	@Required
	public Sender sender;
	
	@Required
	public String status;
	
	@Formats.DateTime(pattern = "dd/MM/yyyy hh:mm:ss")
	public Date dateSent;
	
	@Required
	public EMessage eMessage;
	
	public String message;
}
