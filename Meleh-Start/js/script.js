$(document).ready($(function () {
    $("#UserGridView").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable(
        {

        });

    $('a.toggle-vis').on('click', function (e) {
        e.preventDefault();
        console.log("asd");

        // Get the column API object
        var column = $('#UserGridView').DataTable().column($(this).attr('data-column'));
        
        // Toggle the visibility
        column.visible(!column.visible());
    });
    var $hide = $('#HideColumns');
    $hide.attr('multiple', 'multiple');
    $hide.multiselect({'includeSelectAllOption': true});
}));