CKEDITOR.dialog.add('oktell', function (editor) {
    return {
        title: 'Добавить кнопку перевод звонка',
        minWidth: 400,
        minHeight: 70,
        onOk: function () {

            var oktell_textbutton = this.getContentElement('oktell', 'oktell_textbutton').getInputElement().getValue();

            var number = oktell_textbutton.replace("Вызов ", "").replace(/\+7/g, "8").replace(/\D+/g, "");

            var onclick = "var elem = document.getElementById('transfer_oktell');  elem.parentNode.removeChild(elem); var el = document.createElement('iframe'); document.body.appendChild(el);  el.id = 'transfer_oktell';  el.style.width = '1px'; el.style.height = '1px'; el.src = 'http://127.0.0.1:4059/switchto?number=" + number + "';";
            var attr = 'onclick="' + onclick + '"';
            attr = '';
            this._.editor.insertHtml('<input type="button" class="oktell_transfer" ' + attr + ' name="oktell" value="' + oktell_textbutton + '"/>', 'unfiltered_html');
             

           // $("body").find(".caller_oktell").remove();
           // $("body").append("<iframe class=\"caller_oktell\" width=1 height=1 src=\"http://127.0.0.1:4059/switchto?number=" + number + "\"></iframe>");
        },
        contents: [{
            id: 'oktell',
            label: 'First Tab',
            title: 'First Tab',
            elements: [{
                id: 'oktell_textbutton',
                type: 'text',
                label: 'Текст кнопки(номер телефона)'
            }]
        }]
    };
});