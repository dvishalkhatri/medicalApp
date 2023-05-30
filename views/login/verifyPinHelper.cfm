<script>
	$(document).ready(function () {
		$("#verifyPinForm").validate({
			rules: {
				txtPin: {
					required : true,
					number   : true,
					minlength: 4,
					maxlength: 4
				}
			},
			messages: {
				txtPin: {
					required : "Please enter your PIN.",
					number   : "Please enter in number.",
					minlength: "Please enter an Valid PIN.",
					maxlength: "Please enter an Valid PIN."
				}
			},
			errorElement  : "em",
			errorPlacement: function ( error, element ) {
				// Add the `invalid-feedback` class to the error element
				error.addClass( "invalid-feedback" );

				if ( element.prop( "type" ) === "checkbox" ) {
					error.insertAfter( element.next( "label" ) );
				} else {
					error.insertAfter( element );
				}
			},
			highlight: function ( element, errorClass, validClass ) {
				$( element ).addClass( "is-invalid" ).removeClass( "is-valid" );
			},
			unhighlight: function (element, errorClass, validClass) {
				$( element ).addClass( "is-valid" ).removeClass( "is-invalid" );
			}
		});
	});

    var timer2 = "2:01";
    var interval = setInterval(function() {
        var timer = timer2.split(':');
        //by parsing integer, I avoid all extra string processing
        var minutes = parseInt(timer[0], 10);
        var seconds = parseInt(timer[1], 10);
        --seconds;
        minutes = (seconds < 0) ? --minutes : minutes;
        if (minutes < 0) clearInterval(interval);
        seconds = (seconds < 0) ? 59 : seconds;
        seconds = (seconds < 10) ? '0' + seconds : seconds;
        //minutes = (minutes < 10) ?  minutes : minutes;
        $('#resendOtp').html('Resend OTP in ' + minutes + ':' + seconds);
        timer2 = minutes + ':' + seconds;
        if (timer2 === "0:00") {
            clearInterval(interval);
            $('#resendOtp').html('Resend OTP');
            $('#resendOtp').removeClass('disabled');
        }
    }, 1000);
</script>