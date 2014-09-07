// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
 /*
    // TODO list button
    $('#add-todo-list').on('click', function() {
	alert('you\'ve clicked on "Add TODO List"');
    });
   
    // Header of a project
    $('.icon-edit').on('click', function() {
	alert('you\'ve clicked on "edit" at ' + $(this).closest("ul").find('h1').text());
    });
    
    $('.icon-delete').on('click', function() {
	alert('you\'ve clicked on "trash" at ' + $(this).closest("ul").find('h1').text());
    });
    
    // List items button
    $('.move').on('click', function() {
	alert('you\'ve clicked on "move" at ' + $(this).closest("li").find('label').text());   
    })
    
    $('.edit').on('click', function() {
	alert('you\'ve clicked on "edit" at ' + $(this).closest("li").find('label').text());   
    })

    $('.trash').on('click', function() {
	alert('you\'ve clicked on "trash" at ' + $(this).closest("li").find('label').text());   
    })
    */

	$.ajaxSetup({
	  headers: {
	    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
	  }
	});

    $('.list-group').on('click', 'input' ,function(e) { 
    	var type, id, project, checked;
    	id = $(this).attr('id');
    	project = $(this).closest('.project').attr('id').substring(8);
    	checked = $(this).is(":checked");
    	if ( checked ) {
    		type = 'do';
    	} else {
    		type = 'undo';
    	}
    	console.log('/tasks/' + id + '/' + type);
	    $.ajax({
		    type: 'PATCH',
		    url: '/tasks/' + id + '/' + type,
            dataType: "script",
		    success: function() {
		      console.log('hooray');
		    }
		});
    })

});