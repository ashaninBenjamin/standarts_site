// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require ckeditor/ckeditor
//= require ckeditor/config
//= require_tree .

slideDiv = function (obj) {
    $(obj).slideToggle();
    if (obj.indexOf("block_all_content") != -1) {
        var img = obj.replace("block_all_content", "arrShowContent");
        var angle = 90;
        if ($(img).getRotateAngle() != "")
            angle = ($(img).getRotateAngle() == 90) ? 0 : 90;
        $(img).rotate({animateTo:angle});
    }
};

$(function () {
    $("#header img").load(function() {
        this.width.percent = "100%";
    })
});

$(function () {
    $(".blockName, .blockContentWatchAll, .point").mouseover(function () {
        $(this).addClass("over");
        $(this).addClass("roundMenu");
    }).mouseout(function () {
            $(this).removeClass("over");
            $(this).removeClass("roundMenu");
        });
});

$(document).ready(function () {
    $(".error, .alert, .notice, .success, .info").delay(1500).animate({
        opacity:0.15
    }, 1200).slideToggle();
});

$(document).on("change", "#standard_parent_id", function () {
    var urlstr = '/helper/number_selection?value=' + $("#standard_parent_id option:selected").val()
    if ($("#native_id").text() != "")
        urlstr = '/helper/number_selection?value=' + $("#standard_parent_id option:selected").val() +
            "&native_id=" + $("#native_id").text();
    $.ajax({
        url: urlstr,
        type:'get',
        dataType:'html',
        processData:false,
        success:function (data) {
            $("#number").html(data)
        },
        error:function () {
            alert("fatal error!")
        }
    })
});