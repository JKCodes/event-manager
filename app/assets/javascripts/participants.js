$(document).on('turbolinks:load', function() {

  $("a.load_next, a.load_previous").on("click", function(e) {
    e.preventDefault();

    const indexes = $(this).data("indexes")
    const current_id = +$(this).attr("data-current")
    const current_index = indexes.indexOf(current_id)
    var modified_index = $(this).attr('class') === "load_next" ? current_index + 1 : current_index - 1
    if (modified_index >= indexes.length) { modified_index = 0; }
    if (modified_index < 0) { modified_index = indexes.length - 1; }
    const previous_index = modified_index > 0 ? modified_index - 1 : indexes.length - 1
    const next_index = modified_index < indexes.length - 1 ? modified_index + 1 : 0
    const previous_id = indexes[previous_index]
    const next_id = indexes[next_index]

    $.get(this.href).success(function(json) {
      console.log(json)
      $("div.participant_events").hide()
      $("a.load_previous")[0].href = "/participants/" + previous_id
      $("a.load_next")[0].href = "/participants/" + next_id
      $("a.load_previous").attr("data-current", json.id)
      $("a.load_next").attr("data-current", json.id)
      $("#nickname").html("Nickname: " + json.nickname)
      $("#first_name").html("First Name: " + json.first_name)
      $("#last_name").html("Last Name: " + json.last_name)
      $("#email").html("Email: " + json.email)
      $("#phone_number").html("Phone Number: " + json.phone_number)
    });
  });

  // Participant show events
  $("a.load_events").on("click", function(e) {
    e.preventDefault();

    $.get(this.href).success(function(json) {
      $("a.load_events").hide()

      var $events = $("div.events")
      var html = "<ol>"

      json.forEach(function(event) {
        html += `<li><a href="/events/${event.id}">${event.name}</a></li>`
      })

      html += "</ol>"

      $events.html(html)
    });
  });  
});
