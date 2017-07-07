$(function() {
  $("a.load_events").on("click", function(e) {
    e.preventDefault();

    $.get(this.href).success(function(json) {
      $("div.comments").html("1")
    });
  });  
});
