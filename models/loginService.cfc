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
		var loc   = {};
		loc.query = query.setReturnFormat( "query" )
			.from( "userdb" )
			.where( "email", "=", arguments.formData.email )
			.get();
			
		if ( loc.query.recordCount EQ 1 ) {
			loc.password = BCrypt.checkPassword( arguments.formData.password, loc.query.password );
			if ( loc.password ) {
				/* if ( structKeyExists( arguments.formData, "txtKeepLoggedIn" ) ) {
					loc.setKeepLoggedIn = setKeepLoggedIn( arguments.formData.email );
				} */
				loc.token             = addUserToken( loc.query.pkUserId );
				loc.json[ "success" ] = true;
				loc.json[ "data" ]    = loc.token;
				/* loc.mail = new mail(
					to = "#loc.result.email#",
					from = "dvishalkhatri@yahoo.co.in",
					subject = "OTP Verification for Medical App!",
					body = "You OTP is #loc.token.pin#. You OTP would expire in 2 minutes.",
					type = "html"
				); */
				/* loc.mail.send(); */
				loc.json[ "message" ] = "OTP has been set to your mail! Please do check it!";
				/* sessionStorage.set( "userId", loc.result.pkUserId );
				sessionStorage.set( "username", loc.result.email );
				sessionStorage.set( "firstname", loc.result.firstName );
				sessionStorage.set( "lastname", loc.result.lastName );
				loc.json[ "success" ] = true;
				loc.json[ "message" ] = "Login Successful! Welcome #loc.result.firstName# #loc.result.lastName#!"; */
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


	/**
	 * addUserToken
	 */
	public numeric function addUserToken( required numeric userId, numeric resendPin ){
		var loc = {};
		loc.q   = new query();
		loc.sql = "INSERT INTO usertoken SET fkUserId = :fkUserId, token =:token, tokenPin =:tokenPin, userAgent = :userAgent, tokenExpired = :tokenExpired, tokenExpireTime =:tokenExpireTime";
		loc.q.addParam(
			name      = "fkUserId",
			value     = "#arguments.userId#",
			cfsqltype = "cf_sql_varchar"
		);
		loc.q.addParam(
			name      = "userAgent",
			value     = "#cgi.http_user_agent#",
			cfsqltype = "cf_sql_varchar"
		);
		loc.q.addParam(
			name      = "tokenExpired",
			value     = "#createODBCDateTime( dateAdd( "d", 60, now() ) )#",
			cfsqltype = "cf_sql_timestamp"
		);
		loc.q.addParam(
			name      = "tokenExpireTime",
			value     = "#createODBCDateTime( dateAdd( "m", 2, now() ) )#",
			cfsqltype = "cf_sql_timestamp"
		);
		loc[ "pin" ] = randRange( 1000, 9999 );
		loc.q.addParam(
			name     = "tokenPin",
			value    = "#loc.pin#",
			cfqltype = "cfl_sql_smallint"
		);
		loc.q.addParam(
			name     = "token",
			value    = "#createUUID()#",
			cfqltype = "cfl_sql_smallint"
		);
		loc.q.setSql( loc.sql );
		loc.result = loc.q.execute().getPrefix();
		return loc.pin;
	}


	/**
	 * checkPin
	 */
	public struct function checkPin( required numeric pin, required string token ){
		var loc  = {};
		loc.json = { "success" : false, "message" : "" };
		loc.q    = new query();
		loc.sql  = "SELECT * FROM usertoken WHERE tokenPin =:tokenPin AND token =:token";
		loc.q.addParam(
			name     = "tokenPin",
			value    = "#arguments.pin#",
			cfqltype = "cfl_sql_smallint"
		);
		loc.q.addParam(
			name     = "token",
			value    = "#arguments.token#",
			cfqltype = "cfl_sql_varchar"
		);
		loc.q.setSql( loc.sql );
		loc.result = loc.q.execute().getResult();
		if ( loc.result.recordCount EQ 1 ) {
			if ( dateCompare( loc.result.tokenExpireTime, now() ) EQ -1 ) {
				json[ "success" ] = true;
				sessionStorage.set( "userId", loc.result.pkUserId );
				sessionStorage.set( "username", loc.result.email );
				sessionStorage.set( "firstname", loc.result.firstName );
				sessionStorage.set( "lastname", loc.result.lastName );
				loc.json[ "success" ] = true;
				loc.json[ "message" ] = "Login Successful! Welcome #loc.result.firstName# #loc.result.lastName#!";
			} else {
				loc.json[ "message" ] = "PIN expired!";
			}
		}
		return loc.json;
	}

}
