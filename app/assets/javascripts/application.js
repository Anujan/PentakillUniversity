//= require turbolinks
//= require jquery.turbolinks
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap

$(function () {
        $("[rel='tooltip']").tooltip();
        $('.datatable').dataTable({
		  "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
		  "sPaginationType": "bootstrap"
		});
    });