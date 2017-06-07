// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function(){
	$('#btn-add-note').attr('disabled', true);	
    $('#btn-add-label').attr('disabled', true);

	$('#field_add_title').keyup(function(){
        if($(this).val().length !=0){
            $('#btn-add-note').attr('disabled', false);
        }
        else
        {
            $('#btn-add-note').attr('disabled', true);        
        }
    })

    $('#field_add_label').keyup(function(){
        if($(this).val().length !=0){
            $('#btn-add-label').attr('disabled', false);
        }
        else
        {
            $('#btn-add-label').attr('disabled', true);        
        }
    })
});
