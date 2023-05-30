<cfoutput>
	<div class="row h-100">
		<div class="col-lg-5 col-12">
			<div id="auth-left">
				<h1 class="auth-title">Verify Pin.</h1>
				<p class="auth-subtitle mb-5">Verify Pin with your data that you received in your Email.</p>
				#cbMessageBox().renderIt()#
				<form action="#event.buildLink( "login.checkPin" )#" method="POST" id="verifyPinForm">
					<div class="form-group position-relative has-icon-left mb-4">
						<input type="text" name="txtPin" class="form-control form-control-xl" placeholder="Enter Pin">
						<div class="form-control-icon">
							<i class="bi bi-file-lock2"></i>
						</div>
					</div>
                    <button class="btn btn-warning disabled btn-block btn-lg shadow-lg mt-5" id="resendOtp">Resend OTP in 2:00</button>
					<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5">Verify Pin</button>
				</form>
				<div class="text-center mt-5 text-lg fs-4">
					<p class="text-gray-600">
						<a href="#event.buildLink( "login.index" )#" class="font-bold">Back to Login</a>
					</p>
					<p>
						<a class="font-bold" href="#event.buildLink( "login.forgot" )#">Forgot password?</a>
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
