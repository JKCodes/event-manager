function Location(attributes) {
  this.name = attributes.name
  this.id = attributes.id
}

Location.prototype.renderTr = function() {
  var html = "<tr><td>"
  html += `<a href="/locations/${this.id}">${this.name}</a></td>`
  html += "<td></td><td></td><td></td><td></td><td>"
  html += `<a href="/locations/${this.id}/events">0</a></td></tr>`

  return html
}

Location.prototype.resetForm = function() {
  $("input[type='submit']").removeAttr("disabled")
  $("#location_name").val("")
}

Location.postSuccess = function(json) {
  var location = new Location(json)
  var locationTr = location.renderTr()
  location.resetForm()

  $('tbody').append(locationTr)
}

Location.formSubmit = function(e) {
  e.preventDefault();

  $.ajax({
    type: "POST",
    url: this.action,
    dataType: "json",
    data: $(this).serialize(),
    success: Location.postSuccess
  });
}

Location.clickNavigate = function(e) {
  e.preventDefault();

  const indexes = $(this).data("indexes")
  const current_id = +$(this).attr("data-current")
  const current_index = indexes.indexOf(current_id)
  var modified_index = $(this).attr('class') === "load_next_location" ? current_index + 1 : current_index - 1
  if (modified_index >= indexes.length) { modified_index = 0; }
  if (modified_index < 0) { modified_index = indexes.length - 1; }
  const previous_index = modified_index > 0 ? modified_index - 1 : indexes.length - 1
  const next_index = modified_index < indexes.length - 1 ? modified_index + 1 : 0
  const previous_id = indexes[previous_index]
  const next_id = indexes[next_index]

  $.get(this.href).success(function(json) {
    $("div.location_events").hide()
    $("a.load_previous_location")[0].href = "/locations/" + previous_id
    $("a.load_next_location")[0].href = "/locations/" + next_id
    $("a.load_previous_location").attr("data-current", json.id)
    $("a.load_next_location").attr("data-current", json.id)
    $("#name").html("Name: " + json.name)
    $("#street_address").html("Street Address: " + json.street_address)
    $("#city").html("City: " + json.city)
    $("#state").html("State: " + json.state)
    $("#zipcode").html("Zipcode: " + json.zipcode)
  });
}

Location.clickLoadLocationEvents = function(e) {
  e.preventDefault();

  $.get(this.href).success(Location.clickLoadLocationEventsSuccess);
}

Location.clickLoadLocationEventsSuccess = function(json) {
  $("a.load_location_events").hide()

  var $events = $("div.events")
  var html = "<ol>"

  json.forEach(function(event) {
    html += `<li><a href="/events/${event.id}">${event.name}</a></li>`
  })

  html += "</ol>"

  $events.html(html)
}

$(document).on('turbolinks:load', function() {

  $("#new_location").on('submit', Location.formSubmit);
  $("a.load_next_location, a.load_previous_location").on("click", Location.clickNavigate);  
  $("a.load_location_events").on("click", Location.clickLoadLocationEvents);  
});
