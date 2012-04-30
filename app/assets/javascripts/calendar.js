$(document).ready(function() {
    $('input.ui-date-picker').datepicker({
        dateFormat: "yy-mm-dd",
        appendText: "(yyyy-mm-dd)"
    });
    $('input.ui-datetime-picker').datepicker({
        dateFormat: "yy-mm-dd",
        appendText: "(yyyy-mm-dd)"
    });
});