/**
 * Created with JetBrains RubyMine.
 * User: Victoria
 * Date: 2/7/13
 * Time: 2:11 AM
 * To change this template use File | Settings | File Templates.
 */

$(document).ready(function(){

//    var nowTemp = new Date();
//    var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
//    $('#DiscoveryDate, #CreationDate').each(function(){
//        var picker = $(this).datepicker({
//            onRender: function(date) {
//                return date.valueOf() < now.valueOf() ? 'disabled' : '';
//            }
//        }).on('changeDate', function(ev) {
//                picker.hide();
//            }).data('datepicker');
//    });

    var picHtml = $($("<div/>").append($("#picTemp").clone()).html());
    var provHtml = $($("<div/>").append($("#ownerInfoTemp").clone()).html());
    $("#picTemp").hide();
    $("#ownerInfoTemp").hide();

    $("#addMorePic").click(function(){
        $("#picSection").after(picHtml.clone());
    });

    $("#addMoreProvenance").click(function(){
        $("#ownerInfoSection").after(provHtml.clone());
    });

    $('#permissionForm').click(function(e){
        e.stopPropagation();
    });

    $('.premissionGroupBtn').each(function(){
        $(this).click(function(e){
            e.stopPropagation();
            var name = $(this).attr('name');
            var data = [];
            $('#permissionForm input[type=checkbox]').each(function () {
                if ($(this).is(':checked')) {
                    data.push($(this).attr('name'));
                }
            });
        });
    });
});
