$( document ).ready(function() {
  $( "#due_date" ).change(function() {
    $("#frequency").prop("checked", false);
  });

  $( "#frequency" ).change(function() {
    $("#due_date").val("");
  });
});