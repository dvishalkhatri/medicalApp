/**
 * I am a new Model Object
 */
component accessors="true" {

	// Properties
	property name="sessionStorage" inject="sessionStorage@cbstorages";
	property name="cookieStorage"  inject="cookieStorage@cbstorages";
	property name="BCrypt"         inject="BCrypt@BCrypt";
	property name="query"          inject="provider:QueryBuilder@qb";
	/**
	 * Constructor
	 */
	baseService function init(){
		return this;
	}

}
