function Participant(attributes, previous_id, next_id) {
  this.id = attributes.id === null ? "" : attributes.id
  this.nickname = attributes.nickname === null ? "" : attributes.nickname
  this.first_name = attributes.first_name === null ? "" : attributes.first_name
  this.last_name = attributes.last_name === null ? "" : attributes.last_name
  this.email = attributes.email === null ? "" : attributes.email
  this.phone_number = attributes.phone_number === null ? "" : attributes.phone_number
  this.previous_id = previous_id
  this.next_id = next_id
}

Participant.clickNavigate = function(e) {
  e.preventDefault();

  const indexes = $(this).data("indexes")
  const current_id = +$(this).attr("data-current")
  const current_index = indexes.indexOf(current_id)
  var modified_index = $(this).attr('class') === "load_next_participant" ? current_index + 1 : current_index - 1
  if (modified_index >= indexes.length) { modified_index = 0; }
  if (modified_index < 0) { modified_index = indexes.length - 1; }
  const previous_index = modified_index > 0 ? modified_index - 1 : indexes.length - 1
  const next_index = modified_index < indexes.length - 1 ? modified_index + 1 : 0
  const previous_id = indexes[previous_index]
  const next_id = indexes[next_index]

  $.get(this.href).success(function(json) {
    console.log(json)
    $("div.participant_events").hide()
    $("a.load_previous_participant")[0].href = "/participants/" + previous_id
    $("a.load_next_participant")[0].href = "/participants/" + next_id
    $("a.load_previous_participant").attr("data-current", json.id)
    $("a.load_next_participant").attr("data-current", json.id)
    $("#nickname").html("Nickname: " + json.nickname)
    $("#first_name").html("First Name: " + json.first_name)
    $("#last_name").html("Last Name: " + json.last_name)
    $("#email").html("Email: " + json.email)
    $("#phone_number").html("Phone Number: " + json.phone_number)
  });
}

$(document).on('turbolinks:load', function() {

  $("a.load_next_participant, a.load_previous_participant").on("click", Participant.clickNavigate);

  // Participant show events
  $("a.load_participant_events").on("click", function(e) {
    e.preventDefault();

    $.get(this.href).success(function(json) {
      $("a.load_participant_events").hide()

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
