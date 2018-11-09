/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
    // config.uiColor = '#AADC6E';
    config.extraPlugins = 'oktell';
    config.allowedContent = true;

    config.height = 300;
    // Set the most common block elements.
    config.format_tags = 'p;h1;h2;h3;pre';

    // Simplify the dialog windows.
    //config.removeDialogTabs = 'image:advanced;link:advanced';
    //  config.startupMode = 'source';
    config.filebrowserImageBrowseLinkUrl = "./templates/default/js/ckfinder/ckfinder.html?type=Images";
    config.filebrowserImageUploadLinkUrl = "./templates/default/js/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Images";
};
