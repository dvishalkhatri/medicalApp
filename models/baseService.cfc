/**
 * I am a new Model Object
 */
component accessors="true" {

	// Properties
	property name="sessionStorage" inject="sessionStorage@cbstorages";
	property name="BCrypt"         inject="BCrypt@BCrypt";
	/**
	 * Constructor
	 */
	baseService function init(){
		return this;
	}

}
