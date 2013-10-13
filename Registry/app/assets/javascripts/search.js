/**
 * Created with JetBrains RubyMine.
 * User: Victoria
 * Date: 4/11/13
 * Time: 3:11 AM
 * To change this template use File | Settings | File Templates.
 */

$(document).ready(function(){
    $("#search").click(function(){
        var url = '/search?page=1'
        var data = $('#searchKeyword').val();
        var form = $('<form action="' + url + '" method="post">' +
            '<input type="text" name="keyword" value="' + data + '" />' +
            '</form>');
        $('body').append(form);
        $(form).submit();
    });
});
