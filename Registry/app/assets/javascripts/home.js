/**
 * Created with JetBrains RubyMine.
 * User: Victoria
 * Date: 12/12/12
 * Time: 2:39 PM
 * To change this template use File | Settings | File Templates.
 */

$(document).ready(function(){
    $('#homeCarousel').carousel();

    $("#invitationModal").on("hidden", function(){
        $("#invitationError").text("").hide();
        $("#invitationCode").val("");
    });

    $('#invitationSubmit').click(function(e){
        e.preventDefault();
        $.post('/invite', $('#invitationForm').serialize(), function(data) {
            if (!data.success){
                $("#invitationModal").modal('show');
                $("#invitationError").text(data.message).show();
            }else{
                window.location="/signup"
            }
        });
    });

    $("li.disabled a, li.active a").each(function(){
        $(this).click(function(e){
            return false;
        });
    });
});

function submitForm(e){
    e.preventDefault();
    $.post('/invite', $('#invitationForm').serialize(), function(data) {
        if (!data.success){
            $("#invitationModal").modal('show');
            $("#invitationError").text(data.message).show();
        }else{
            window.location="/signup"
        }
    });
}
