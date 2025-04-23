$(document).ready(function () {
    $("#customerForm").validate({
        rules: {
            email: {
                required: true,
                email: true
            },
            firstname: "required",
            lastname: "required",
            password: "required",
            confirmPassword: {
                required: true,
                equalTo: "#password"
            },
            phone: "required",
            address1: "required",
            address2: "required",
            city: "required",
            state: "required",
            zipcode: "required",
            country: "required"
        },
        messages: {
            email: {
                required: "Please enter an e-mail address.",
                email: "Please enter a valid e-mail address.",
            },
            firstname: "Please enter first name.",
            lastname: "Please enter first name.",
            password: "Please enter password.",
            confirmPassword: {
                required: "Please confirm password.",
                equalTo: "Confirm password does not match the password.",
            },
            phone: "Please enter phone number.",
            address1:
                "Pleas enter address line 1.",
            address2:
                "Pleas enter address line 2.",
            city:
                "Please enter city.",
            state:
                "Please enter state.",
            zipcode:
                "Please enter zip code.",
            country:
                "Please enter country.",
        }
    });
});