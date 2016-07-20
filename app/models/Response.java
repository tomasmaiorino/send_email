package models;

public class Response {
	
	public Response(){}
	
	public Response (String message, int code) {
		this.message = message;
		this.code = code;
	}
	
	public Response (String message, int code, Object result) {
		this.message = message;
		this.code = code;
		this.result = result;
	}

	public String message;
	
	public int code;
	
	public Object result;
	
}
