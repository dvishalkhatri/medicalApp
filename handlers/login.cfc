/**
 * I am a new handler
 */
component extends="base" {

	/**
	 * index
	 */
	function index( event, rc, prc ){
		event.setView( view = "login/index", layout = "login" );
	}

	/**
	 * doLogin
	 */
	function doLogin( event, rc, prc ){
		event.setView( "login/doLogin" );
	}

	/**
	 * signUp
	 */
	function signUp( event, rc, prc ){
		var formData = event.getExcept( "event,fieldnames" );
		if (structKeyExists(formData, "txtUserId") AND formData.txtUserId EQ 0) {
			prc.register = loginService.register( formData );
			writeDump(prc.register);abort;
		} else {
			event.setView( view = "login/signUp", layout = "login" );
		}
	}

	/**
	 * forgot
	 */
	function forgot( event, rc, prc ){
		event.setView( view = "login/forgot", layout = "login" );
	}

	
	/**
	 * logout
	 */
	function logout( event, rc, prc ){

	}
	

}
