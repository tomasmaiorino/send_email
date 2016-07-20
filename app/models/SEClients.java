package models;

import javax.persistence.Entity;
import javax.persistence.Id;

import play.data.validation.Constraints.Required;

@Entity
public class SEClients {

	@Id
    public Long id;
	
	@Required
	public String name;
	
	@Required
	public String token;
	
	@Required
	public String host;
	
	@Required
	public Sender sender;
}
