<cfoutput>
	<!DOCTYPE html>
	<html lang="en">
		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>
				<cfif event.getCurrentEvent() EQ "login.index">
					Login
					<cfelseif event.getCurrentEvent() EQ "login.signUp">
					Sign Up
					<cfelseif event.getCurrentEvent() EQ "login.forgot">
					Forgot Password
				</cfif>
			</title>
			<link rel="stylesheet" href="/includes/assets/css/main/app.css">
			<link rel="stylesheet" href="/includes/assets/css/pages/auth.css">
			<link rel="shortcut icon" href="/includes/assets/images/logo/favicon.svg" type="image/x-icon">
			<link rel="shortcut icon" href="/includes/assets/images/logo/favicon.png" type="image/png">
			<script src="/includes/assets/extensions/jquery/jquery.min.js"></script>
			<script src="/includes/assets/js/pswmeter.min.js"></script>
			<script src="/includes/assets/js/extensions/jquery-validator/jquery.validate.min.js"></script>
			<script src="/includes/assets/js/extensions/jquery-validator/additional-methods.min.js"></script>
		</head>

		<body>
			<div id="auth">
				#renderView()#
			</div>
			<cfif event.getCurrentEvent() EQ "login.signUp">
				<script>
					const myPassMeter = passwordStrengthMeter({
						containerElement: '##pswmeter',
						passwordInput   : '##psw-input',
						showMessage     : true,
						messageContainer: '##pswmeter-message',
						messagesList    : [
							'Write your password...',
							'Easy peasy!',
							'That is a simple one',
							'That is better',
							'Yeah! that password rocks ;)'
						],
						height      : 6,
						borderRadius: 0,
						pswMinLength: 8,
						colorScore1 : '##ff8a8a',
						colorScore2 : '##fffd98',
						colorScore3 : '##ffb958',
						colorScore4 : 'limegreen'
					});
				</script>
			</cfif>
		</body>
	</html>
</cfoutput>
