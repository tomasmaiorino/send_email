package models;

import javax.persistence.Entity;
import javax.persistence.Id;

import play.data.validation.Constraints.Required;

@Entity
public class Sender {
	
	@Id
    public Long id;
	
	@Required
	public String name;
	
	public Boolean active = false;
	
	@Required
	public String senderClass;
}
