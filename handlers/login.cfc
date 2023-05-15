/**
 * I am a new handler
 */
component {

	property name="sessionStorage" inject="sessionStorage@cbstorages";
	property name="loginService" inject="loginService";

	/**
	 * index
	 */
	function index( event, rc, prc ){
		if (sessionStorage.exists( "userId" )) {
			relocate("home/index");
		} else {
			event.setView( "login/index" ).setLayout( "login" );
		}
	}

	/**
	 * doLogin
	 */
	function doLogin( event, rc, prc ){
		var formData = event.getExcept( "event,fieldnames" );
		if (sessionStorage.exists( "userId" )) {
			relocate('home.index');
		} else if (structKeyExists(formData, "email") AND len(trim(formData.email)) GT 0) {
			var prc.checkLogin = loginService.checkLogin(formData);
		} else {
			event.setView( "login/doLogin" );
		}
	}

	/**
	 * signUp
	 */
	function signUp( event, rc, prc ){
		var formData = event.getExcept( "event,fieldnames" );
		if (sessionStorage.exists( "userId" )) {
			relocate('home.index');
		} else if (structKeyExists(formData, "txtUserId") AND formData.txtUserId EQ 0) {
			prc.register = loginService.register( formData );
			if (prc.register.recordCount EQ 1) {
				relocate('home/index');
			}
		} else {
			event.setView( "login/signUp" ).setLayout( "login" );
		}
	}

	/**
	 * forgot
	 */
	function forgot( event, rc, prc ){
		event.setView( "login/forgot" ).setLayout( "login" );
	}

	
	/**
	 * logout
	 */
	function logout( event, rc, prc ){
		if (sessionStorage.exists( "userId" )) {
			sessionStorage.clearAll();
			relocate('login/index');
		}
	}
	

}
