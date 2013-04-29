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
//= require js-routes
//= require ckeditor/ckeditor
//= require ckeditor/config
//= require_tree .

$(function () {
    $("#header img").load(function () {
        this.width.percent = "100%";
    });
});

$(function () {
    $(".blockName, .blockContentWatchAll, .point").mouseover(function () {
        $(this).addClass("over, roundMenu");
    }).mouseout(function () {
            $(this).removeClass("over, roundMenu");
        });
});

$(document).ready(function () {
    $("div.error, div.alert, div.notice, div.success, div.info").delay(1500).animate({
        opacity: 0.15
    }, 1200).slideToggle();
});

$(document).on("change", "#standard_parent_id", function () {
    var urlstr = Routes.helper_number_selection_path({value: $("#standard_parent_id option:selected").val()});
    if ($("#native_id").text())
        urlstr = Routes.helper_number_selection_path({value: $("#standard_parent_id option:selected").val(),
            native_id: $("#native_id").text() });
    $.ajax({
        url: urlstr,
        type: 'get',
        dataType: 'html',
        processData: false,
        success: function (data) {
            $("#number").html(data);
        },
        error: function () {
            alert("fatal error!");
        }
    });
});

$(function () {
    $("#q_reset").click(function () {
        $("#q_state_cont, #q_access_state_cont").val("");

    });
});