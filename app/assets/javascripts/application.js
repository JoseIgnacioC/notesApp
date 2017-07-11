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

    
    //Momentaneo - esconder mensaje de vacios
    $('.msjeEmpty').each(function(){
        $(this).hide();
    })

    //Deshabilitar  y habilitar boton del formulario para agregar
	$('#btn-add-note').attr('disabled', true);	
    $('#btn-add-label').attr('disabled', true);

    console.log("HOLA");

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

//Funcion para actualizar estado de una nota
jQuery.fn.submitOnCheck = function() {    
    this.find('input[type=checkbox]').click(function() {
        $(this).closest('form').submit();
    });
    return this;
}
$(function() {
    $('.item-note').submitOnCheck();
});

//Funcion para actualizar el color un label
jQuery.fn.submitChangeColor = function(){
    this.find('input[type=color]').change(function(){
        $(this).closest('form').submit();
    });
    return this;
}

$(function(){
    $('.color-label').submitChangeColor();
});

//Funcion para actualizar el titulo de un label
jQuery.fn.submitChangeLabel = function(){
    this.find('input[type=text]').change(function(){
        $(this).closest('form').submit();
    });
    return this;
}

$(function(){
    $('.title-label').submitChangeLabel();
});

//Funcion para filtrar labels
jQuery.fn.filterLabels = function() {
    this.find('input[type=checkbox]').click(function() {
        var idLabel = this.name;
        var idsLabels = labelsChecked();        
        $.ajax({
            url: "/notes/filter_labels/"+idLabel,
            datatype: "JSON",
            data: {'arrayL': idsLabels},
            timeout: 10000,
            beforeSend: function(){
                $('.notice').html("Cargando...");
            },
            error: function(){
                $('.notice').html("Error...");
            },
            success: function(res){
                if(res){
                    $('.notice').html("Listo los "+res.length+" notas del label ...");                    
                    showLabelsSelected(res, idsLabels.length);                    
                }
                else{
                    $('.notice').html("No existe...");
                }
            }
        })
    });
    return this;
}
$(function() {
    $('.item-label').filterLabels();
});

var labelsChecked = function(){

    var idsLabels = [];    
    $('.check-label').each(function(index){
        if($(this).prop('checked')){
           idsLabels.push($(this).val());        
        }
    })
    return idsLabels;
}

var showLabelsSelected = function(arrayNotes, nroLabels){    

    if(nroLabels != 0){
        $('.item-note').each(function(index){
            $(this).hide();
        })

        for( var i=0; i < arrayNotes.length; i++){

            var idNote = "#note_"+arrayNotes[i].id;
            console.log(arrayNotes[i].id);
            $(idNote).each(function(index){
                $(this).show();
            })
        }
    }
    else{
        $('.item-note').each(function(index){
            $(this).show();
        })        
    }
}