

$(document).ready(function () {

    $(".transfer").live("click",function () {
        var prefix = "98"; 
        var phone = $(this).val().replace("Вызов ", "").replace(/\D+/g, ""); 
        number = (phone.length==4?prefix:"") + phone; 
        transfer(number);
        return false;
    });

    $(".nextoktell").live("click", function () { 
        setTimeout("next_oktell()",500);
        return true;
    });

    

   // $(window).unload(function () {
    //    $.get( "handler.ashx");
//    });
  
});

function myOnUlLoad() {
    
    $.get('handler.ashx?r='+ Math.random());
}
  


function transfer_oktell(number) {
    $("body").find(".caller_oktell").remove();
    $("body").append("<iframe class=\"caller_oktell\" width=1 height=1 src=\"http://127.0.0.1:4059/switchto?number=" + number + "\"></iframe>"); 
}



function next_oktell() {
    $("body").find(".next_oktell").remove();
    $("body").append("<iframe class=\"next_oktell\" width=1 height=1 src=\"http://127.0.0.1:4059/dialogcardnext\"></iframe>");
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


