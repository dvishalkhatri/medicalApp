<script>
	$(document).ready(function() {
		$("#loginForm").validate({
			rules: {
				email: {
					required : true,
					email    : true,
					minlength: 5
				},
				password: {
					required : true,
					minlength: 5
				}
			},
			messages: {
				email: {
					required : "Please enter your email.",
					email    : "Please enter a valid email.",
					minlength: "Please enter an email with minimum length of 5 characters."
				},
				password: {
					required : "Please provide a password.",
					minlength: "Your password must be at least 5 characters long."
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
				$( element ).siblings( ".form-control-icon-right" ).addClass( "is-invalid" ).removeClass( "is-valid" );
			},
			unhighlight: function (element, errorClass, validClass) {
				$( element ).addClass( "is-valid" ).removeClass( "is-invalid" );
				$( element ).siblings( ".form-control-icon-right" ).addClass( "is-valid" ).removeClass( "is-invalid" );
			}
		});
	});
</script>