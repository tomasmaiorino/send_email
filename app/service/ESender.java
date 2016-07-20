package service;

import exception.SendEMessageException;
import models.EMessage;

public interface ESender {

	public Object sendEmail(EMessage message) throws SendEMessageException;
}
