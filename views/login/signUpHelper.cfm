<script>
    const myPassMeter = passwordStrengthMeter({
        containerElement: '##pswmeter',
        passwordInput: '##psw-input',
        showMessage: true,
        messageContainer: '##pswmeter-message',
        messagesList: [
            'Write your password...',
            'Easy peasy!',
            'That is a simple one',
            'That is better',
            'Yeah! that password rocks ;)'
        ],
        height: 6,
        borderRadius: 0,
        pswMinLength: 8,
        colorScore1: '##ff8a8a',
        colorScore2: '##fffd98',
        colorScore3: '##ffb958',
        colorScore4: 'limegreen'
    });
    $(document).ready(function () {
        $("#signUpForm").validate({
            rules: {
                txtEmail: {
                    required: true,
                    email: true,
                    minlength: 5
                },
                txtFirstname: "required",
                txtLastname: "required",
                txtPassword: {
                    required: true,
                    minlength: 5
                },
                txtConfirmPassword: {
                    required: true,
                    minlength: 5,
                    equalTo: "#psw-input"
                }
            },
            messages: {
                txtEmail: {
                    required: "Please enter your email.",
                    email: "Please enter a valid email.",
                    minlength: "Please enter an email with minimum length of 5 characters."
                },
                txtFirstname: "Please enter your firstname.",
                txtLastname: "Please enter your lastname.",
                txtPassword: {
                    required: "Please provide a password.",
                    minlength: "Your password must be at least 5 characters long."
                },
                txtConfirmPassword: {
                    required: "Please provide a password.",
                    minlength: "Your password must be at least 5 characters long.",
                    equalTo: "Please enter the same password as above."
                }
            },
            errorElement: "em",
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
        $( ".bi-eye, .bi-eye-slash" ).click(function() {
            if($("#psw-input").attr("type") === "password") {
                $("#psw-input").attr("type", "text");
                $(this).removeClass( "bi-eye" ).addClass( "bi-eye-slash" );
            } else {
                $( "#psw-input" ).attr("type", "password");
                $( this ).removeClass( "bi-eye-slash" ).addClass( "bi-eye" );
            }
        });
        $( "#psw-input" ).change(function() {
            if($( this ).val().trim().length > 0) {
                $( "#pswmeter" ).removeClass( "d-none" );
                $( "#pswmeter-message" ).removeClass( "d-none" );
            } else {
                $( "#pswmeter" ).addClass( "d-none" );
                $( "#pswmeter-message" ).addClass( "d-none" );
            }
        });
    });
</script>