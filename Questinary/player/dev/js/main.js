

$(document).ready(function () {

    $(".oktell_transfer").live("click", function () {
        var prefix = ""; 
        var phone = $(this).val().replace("Вызов ", "").replace(/\D+/g, ""); 
        number = prefix  + phone;
        transfer_oktell(number);
        return false;
    });

   // $(window).unload(function () {
    //    $.get( "handler.ashx");
    //    });


    $(".outbound").live("click", function () {
        var prefix = "38";
        var IdInList = $(this).attr("title");
        var phone = $(this).val().replace("Вызов ", "").replace(/\+7/g, "8").replace(/\D+/g, "");
        number = prefix + IdInList + phone;
        outbound_oktell(number);
        return false;
    });


    
});
 



function outbound_oktell(number) {
    $("body").find(".outbound_oktell").remove();
    $("body").append("<iframe class=\"outbound_oktell\" width=1 height=1 src=\"http://127.0.0.1:4059/callto?number=" + number + "\"></iframe>");

}


function transfer_oktell(number) {
    $("body").find(".caller_oktell").remove();
    $("body").append("<iframe class=\"caller_oktell\" width=1 height=1 src=\"http://127.0.0.1:4059/switchto?number=" + number + "\"></iframe>");
    
}


function transfer(number) {
    //ID("id_phone_number").value = number;
    try {
        transferWACMD(number);
    }
    catch (e) {
        alert("Данный функционал совместим только в режиме работы с WebAgent! Набран номер: " + number);
    }
}

function transferWACMD(number) {
    document.parentWindow.external.WACMD("TRANSFER", number);
}


function transfersmall(number) {
    document.parentWindow.external.WACMD("TRANSFER", number);
}


