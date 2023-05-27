/**
 * I am a new Model Object
 */
component extends="baseService" {

	/**
	 * register
	 */
	public struct function register( required struct formData ){
		var loc  = {};
		loc.json = { "success" : false, "message" : "" };
		loc.q    = new query();
		loc.sql  = "SELECT email FROM userdb WHERE email = :email AND pkUserId != :id";
		loc.q.addParam(
			name      = "email",
			value     = "#arguments.formData.txtEmail#",
			cfsqltype = "cf_sql_varchar"
		);
		loc.q.addParam(
			name      = "id",
			value     = "0",
			cfsqltype = "cf_sql_integer"
		);
		loc.q.setSql( loc.sql );
		loc.result = loc.q.execute().getResult();
		if ( loc.result.recordCount GT 0 ) {
			loc.json[ "message" ] = "User with similar Email ID already exists";
		} else {
			loc.sql = "INSERT INTO userdb SET firstName = :firstName, lastName = :lastName, email = :email, createdBy = :createdBy";

			loc.q.addParam(
				name      = "firstName",
				value     = "#arguments.formData.txtFirstname#",
				cfsqltype = "cf_sql_varchar"
			);
			loc.q.addParam(
				name      = "lastName",
				value     = "#arguments.formData.txtLastname#",
				cfsqltype = "cf_sql_varchar"
			);
			loc.q.addParam(
				name      = "createdBy",
				value     = 1,
				cfsqltype = "cf_sql_integer"
			);
			if ( structKeyExists( arguments.formData, "txtPassword" ) AND len( arguments.formData.txtPassword ) GT 0 ) {
				loc.sql &= ", password = :password";
				loc.password = BCrypt.hashPassword( arguments.formData.txtPassword );
				loc.q.addParam(
					name      = "password",
					value     = "#loc.password#",
					cfsqltype = "cf_sql_varchar"
				);
			}
			loc.q.setSql( loc.sql );
			loc.result = loc.q.execute().getPrefix();

			if ( loc.result.recordCount EQ 1 ) {
				sessionStorage.set( "userId", loc.result.generatedkey );
				sessionStorage.set( "username", arguments.formData.txtEmail );
				sessionStorage.set( "firstname", arguments.formData.txtFirstname );
				sessionStorage.set( "lastname", arguments.formData.txtLastname );
				loc.json[ "success" ] = true;
				loc.json[ "message" ] = "User created Successful! Welcome #arguments.txtFirstname# #arguments.txtLastname#!";
			}
		}
		return loc.json;
	}

	/**
	 * checkLogin
	 */
	public struct function checkLogin( required struct formData ){
		var loc  = {};
		loc.json = { "success" : false, "message" : "" };
		loc.q    = new query();
		loc.sql  = "SELECT * FROM userdb WHERE email = :email";
		loc.q.addParam(
			name      = "email",
			value     = "#arguments.formData.email#",
			cfsqltype = "cf_sql_varchar"
		);
		loc.q.setSql( loc.sql );
		loc.result = loc.q.execute().getResult();

		if ( loc.result.recordCount EQ 1 ) {
			loc.password = BCrypt.checkPassword( arguments.formData.password, loc.result.password );
			if ( loc.password ) {
				sessionStorage.set( "userId", loc.result.pkUserId );
				sessionStorage.set( "username", loc.result.email );
				sessionStorage.set( "firstname", loc.result.firstName );
				sessionStorage.set( "lastname", loc.result.lastName );
				loc.json[ "success" ] = true;
				loc.json[ "message" ] = "Login Successful! Welcome #loc.result.firstName# #loc.result.lastName#!";
			} else {
				loc.json[ "message" ] = "Incorrect Password!";
			}
		} else {
			loc.json[ "message" ] = "Invalid Credentials!";
		}
		return loc.json;
	}



	/**
	 * setKeepLoggedIn
	 */
	function setKeepLoggedIn( required string email ){
		var loc  = {};
		loc.json = { "success" : false, "message" : "" };
		loc.q    = new query();
		loc.sql  = "SELECT isPasswordChange, email FROM userdb WHERE email = :email";
		loc.q.addParam(
			name      = "email",
			value     = "#arguments.email#",
			cfsqltype = "cf_sql_varchar"
		);
		loc.q.setSql( loc.sql );
		loc.result = loc.q.execute().getResult();
		if ( loc.result.recordCount EQ 1 AND loc.result.isPasswordChange EQ 0 ) {
			loc.encryptEmail = encrypt(
				loc.result.email,
				"BLOWFISH",
				"BLOWFISH",
				"Base64"
			);
			cookieStorage.set( "keeploggedIn", loc.encryptEmail, "never" );
		}
	}



	/**
	 * checkPasswordChange
	 */
	public query function checkPasswordChange(){
		var loc          = {};
		loc.getCookieVal = cookieStorage.get( "keeploggedIn" );
		if ( len( loc.getCookieVal ) GT 0 ) {
			loc.decryptEmail = decrypt(
				loc.getCookieVal,
				"BLOWFISH",
				"BLOWFISH",
				"Base64"
			);
			loc.q   = new query();
			loc.sql = "SELECT * FROM userdb WHERE email = :email";
			loc.q.addParam(
				name      = "email",
				value     = "#loc.decryptEmail#",
				cfsqltype = "cf_sql_varchar"
			);
			loc.q.setSql( loc.sql );
			loc.result = loc.q.execute().getResult();
			return loc.result;
		}
	}

}
