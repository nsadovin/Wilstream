$(document).ready(function () { 
    $(".button-caller").live("click", function () {
        
        var c = $(this);
        var ObjectId = $(this).attr("ObjectId");
        var TRANSFERED_PHONE = $("#HiddenFieldTP" + ObjectId).val();
        var TRANSFERED_QUEUE = $("#HiddenFieldTQ" + ObjectId).val();
        var ExtStation = $(".table-contacts-" + ObjectId + " .ext-station:first").text();
        ExtStation = c.attr("extstation");
        var number = TRANSFERED_PHONE + "zw" + ExtStation; 
        transfer_oktell(number);
        return true;
        c.timer({
            duration: TRANSFERED_QUEUE + 's',
            callback: function () {
           //     alert(1); 
            } 
        });
        var checkTimer = setInterval(checkCallFunction, 5000);

        $(this).attr("disabled", "disabled");
    });


    $(".oktell_transfer").live("click", function () {
        var prefix = "";
        if ($(this).attr("prefix"))
            prefix = $(this).attr("prefix");
        var phone = $(this).val().replace("Вызов ", "").replace(/\D+/g, "");
        number = prefix + phone;
        transfer_oktell(number);
        return false;
    });
    
});

function checkCallFunction() {



}


function transfer_oktell(number) {
    $("body").find(".caller_oktell").remove();
    $("body").append("<iframe class=\"caller_oktell\" width=1 height=1 src=\"http://127.0.0.1:4059/switchto?number=" + number + "\"></iframe>");

}