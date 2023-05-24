/**
 * I am a new handler
 */
component {

	property name="loginService"   inject="loginService";
	property name="sessionStorage" inject="sessionStorage@cbstorages";

	function preHandler( event, rc, prc, action, eventArguments ){
		if ( sessionStorage.exists( "userId" ) ) {
			prc[ "userId" ]    = sessionStorage.get( "userId" );
			prc[ "firstname" ] = sessionStorage.get( "firstname" );
			prc[ "lastname" ]  = sessionStorage.get( "lastname" );
			prc[ "username" ]  = sessionStorage.get( "username" );
		} else {
			relocate( "login/index" );
		}
	}

}
