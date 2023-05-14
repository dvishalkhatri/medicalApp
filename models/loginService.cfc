/**
 * I am a new Model Object
 */
component extends="baseService" {

	// Properties

	/**
	 * authenticate
	 */
	function authenticate(){
	}

	/**
	 * register
	 */
	public struct function register( required struct formData ){
		var loc = {};
		loc.q   = new query();
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
			name      = "email",
			value     = "#arguments.formData.txtEmail#",
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
		var loc.result = loc.q.execute().getPrefix();

		if (loc.result.recordCount EQ 1) {
			SessionStorage.createStorage();
			sessionStorage.set("userId", loc.result.generatedkey);
			sessionStorage.set("username", arguments.formData.txtEmail);
			sessionStorage.set("firstname", arguments.formData.txtFirstname);
			sessionStorage.set("lastname", arguments.formData.txtLastname);
		}

		return loc.result;
	}

}
