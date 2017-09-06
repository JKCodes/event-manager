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
    var participant = new Participant(json, previous_id, next_id)
    Participant.clickNavigateSuccess(participant)
  });
}

Participant.clickNavigateSuccess = function(participant) {
  $("div.participant_events").hide()
  $("#main_head").html("Participant Details - Viewing Mode")
  $("a.load_previous_participant")[0].href = "/participants/" + participant.previous_id
  $("a.load_next_participant")[0].href = "/participants/" + participant.next_id
  $("a.load_previous_participant").attr("data-current", participant.id)
  $("a.load_next_participant").attr("data-current", participant.id)
  $("#nickname").html("Nickname: " + participant.nickname)
  $("#first_name").html("First Name: " + participant.first_name)
  $("#last_name").html("Last Name: " + participant.last_name)
  $("#email").html("Email: " + participant.email)
  $("#phone_number").html("Phone Number: " + participant.phone_number)
}

Participant.clickLoadParticipantEvents = function(e) {
  e.preventDefault();

  $.get(this.href).success(function(json) {
    $("a.load_participant_events").hide()

    var events = new EventCollection()
    json.forEach((event) => events.addEvent(event))
    var eventsOl = events.renderOl()
    $("div.events").html(eventsOl)
  });
}

Participant.eventListners = function() {
  $("a.load_next_participant, a.load_previous_participant").on("click", Participant.clickNavigate);
  $("a.load_participant_events").on("click", Participant.clickLoadParticipantEvents);  
}

Participant.ready = function() {
  Participant.eventListners()
}

$(document).on('turbolinks:load', function() {
  Participant.ready()
});
