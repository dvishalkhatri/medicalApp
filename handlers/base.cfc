/**
 * I am a new handler
 */
component {

	property name="loginService" inject="loginService";
	property name="sessionStorage" inject="sessionStorage@cbstorages";

	function preHandler( event, rc, prc, action, eventArguments ){
		/* writeDump(sessionStorage.get("userId"));
		writeDump(sessionStorage.exists("username"));
		writeDump(sessionStorage.getStorage()); */
		/* sessionStorage.removeStorage();
		writeDump(sessionStorage.getStorage()); */
		if (sessionStorage.get("userId") GT 0) {
			relocate(event="main.index");
		}
		
	}

}
