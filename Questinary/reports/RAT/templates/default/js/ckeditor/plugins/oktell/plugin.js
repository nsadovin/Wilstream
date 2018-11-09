CKEDITOR.plugins.add('oktell', {
    icons: 'oktell',
    init: function (editor) {

        var command = editor.addCommand('insertOktell', new CKEDITOR.dialogCommand('oktell'));
        command.modes = { wysiwyg: 1, source: 1 };
        command.canUndo = true;

        /*
        editor.addCommand('insertOktell', {
            exec: function (editor) {
                var now = new Date();
                editor.insertHtml('<input type="button" class="oktell" name="oktell" value="Call To"/>');
            }
        });*/
        editor.ui.addButton('oktell', {
            label: 'Добавить кнопку Октелл',
            command: 'insertOktell',
            toolbar: 'insert'
        });

        CKEDITOR.dialog.add('oktell', this.path + 'dialogs/oktell.js');

    }
});


