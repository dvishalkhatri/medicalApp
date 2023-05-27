/**
 * I am a new handler
 */
component {

	property name="loginService"   inject="loginService";
	property name="sessionStorage" inject="sessionStorage@cbstorages";
	property name="cookieStorage"  inject="cookieStorage@cbstorages";

	function preHandler( event, rc, prc, action, eventArguments ){
		if ( cookieStorage.exists( "keeploggedIn" ) ) {
			var checkPasswordChange = loginService.checkPasswordChange();
			if ( checkPasswordChange.recordCount EQ 1 ) {
				prc[ "userId" ]    = checkPasswordChange.pkUserId;
				prc[ "firstname" ] = checkPasswordChange.firstName;
				prc[ "lastname" ]  = checkPasswordChange.lastName;
				prc[ "username" ]  = checkPasswordChange.email;
			}
		} else if ( sessionStorage.exists( "userId" ) ) {
			prc[ "userId" ]    = sessionStorage.get( "userId" );
			prc[ "firstname" ] = sessionStorage.get( "firstname" );
			prc[ "lastname" ]  = sessionStorage.get( "lastname" );
			prc[ "username" ]  = sessionStorage.get( "username" );
		} else {
			relocate( "login/index" );
		}
	}

}
