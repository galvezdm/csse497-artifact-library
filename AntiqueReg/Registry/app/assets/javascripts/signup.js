/**
 * Created with JetBrains RubyMine.
 * User: kyle
 * Date: 12/19/12
 * Time: 3:48 PM
 * To change this template use File | Settings | File Templates.
 */

$(document).ready(function(){
    $("#ConfirmPassword, #Password").change(function(){
        if ($("#ConfirmPassword").val().length != 0 && $("#ConfirmPassword").val() != $("#Password").val()) {
            $("#passwordError").show();
            $("#submitBtn").hide();
        } else {
            $("#passwordError").hide();
            $("#submitBtn").show();
        }
    });

    $("#signUpSubmit").click(function(){
        var userInfo = $("#signUpForm").serialize();

        $.post("/signup", userInfo, function(data) {
            $("#signUpModal").modal('show');
        });
    });

    $('#signInSubmit').click(function(e){
        e.preventDefault();
        $('#signInForm').submit();
    });
});