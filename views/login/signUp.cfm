<cfoutput>
	<div class="row h-100">
		<div class="col-lg-5 col-12">
			<div id="auth-left">
				<!---
					<div class="auth-logo">
					<a href="index.html">
					<img src="/includes/assets/images/logo/logo.svg" alt="Logo">
					</a>
					</div>
				--->
				<h1 class="auth-title">Sign Up</h1>
				<p class="auth-subtitle mb-5">Input your data to register to our website.</p>
				#cbMessageBox().renderIt()#
				<form action="#event.buildLink( "login.signUp" )#" method="POST" id="signUpForm">
					<input type="hidden" name="txtUserId" value="0">
					<div class="form-group position-relative has-icon-left mb-4">
						<input type="text" name="txtEmail" class="form-control form-control-xl" placeholder="Email">
						<div class="form-control-icon">
							<i class="bi bi-envelope"></i>
						</div>
					</div>
					<div class="form-group position-relative has-icon-left mb-4">
						<input
							type       ="text"
							name       ="txtFirstname"
							class      ="form-control form-control-xl"
							placeholder="First Name"
						>
						<div class="form-control-icon">
							<i class="bi bi-person"></i>
						</div>
					</div>
					<div class="form-group position-relative has-icon-left mb-4">
						<input
							type       ="text"
							name       ="txtLastname"
							class      ="form-control form-control-xl"
							placeholder="Last Name"
						>
						<div class="form-control-icon">
							<i class="bi bi-person"></i>
						</div>
					</div>
					<div class="form-group position-relative has-icon-both mb-4">
						<input
							type       ="password"
							name       ="txtPassword" id="psw-input"
							class      ="form-control form-control-xl"
							placeholder="Password"
						>
						<div class="form-control-icon">
							<i class="bi bi-shield-lock"></i>
						</div>
						<div class="form-control-icon-right">
							<i class="bi bi-eye"></i>
						</div>
						<div id="pswmeter" class="mt-3 d-none"></div>
						<div id="pswmeter-message" class="mt-3 d-none"></div>
					</div>
					<div class="form-group position-relative has-icon-left mb-4">
						<input
							type       ="password"
							name       ="txtConfirmPassword"
							class      ="form-control form-control-xl"
							placeholder="Confirm Password"
						>
						<div class="form-control-icon">
							<i class="bi bi-shield-lock"></i>
						</div>
					</div>
					<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5">Sign Up</button>
				</form>
				<div class="text-center mt-5 text-lg fs-4">
					<p class="text-gray-600">
						Already have an account?  <a href="#event.buildLink( "login.index" )#" class="font-bold">Log in.</a>
					</p>
				</div>
			</div>
		</div>
		<div class="col-lg-7 d-none d-lg-block">
			<div id="auth-right">
				
			</div>
		</div>
	</div>
</cfoutput>
