function Location(attributes, previous_id, next_id) {
  this.name = attributes.name === null ? "" : attributes.name
  this.id = attributes.id === null ? "" : attributes.id
  this.street_address = attributes.street_address === null ? "" : attributes.street_address
  this.city = attributes.city === null ? "" : attributes.city
  this.state = attributes.state === null ? "" : attributes.state
  this.zipcode = attributes.zipcode === null ? "" : attributes.zipcode
  this.previous_id = previous_id
  this.next_id = next_id
}

Location.prototype.renderTr = function() {
  return (`
    <tr>
      <td>
        <a href="/locations/${this.id}">${this.name}</a>
      </td>
      <td>${this.street_address}</td>
      <td></td>
      <td></td>
      <td></td>
      <td>
        <a href="/locations/${this.id}/events">0</a>
      </td>
    </tr>
  `);
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
    var location = new Location(json, previous_id, next_id)
    Location.clickNavigateSuccess(location)
  });
}

Location.clickNavigateSuccess = function(location) {
  $("div.location_events").hide()
  $("a.load_previous_location")[0].href = "/locations/" + location.previous_id
  $("a.load_next_location")[0].href = "/locations/" + location.next_id
  $("a.load_previous_location").attr("data-current", location.id)
  $("a.load_next_location").attr("data-current", location.id)
  $("#name").html("Name: " + location.name)
  $("#street_address").html("Street Address: " + location.street_address)
  $("#city").html("City: " + location.city)
  $("#state").html("State: " + location.state)
  $("#zipcode").html("Zipcode: " + location.zipcode)
}

Location.clickLoadLocationEvents = function(e) {
  e.preventDefault();

  $.get(this.href).success(Location.clickLoadLocationEventsSuccess);
}

Location.clickLoadLocationEventsSuccess = function(json) {
  $("a.load_location_events").hide()
  var events = new EventCollection()
  json.forEach((event) => events.addEvent(event))
  var eventsOl = events.renderOl()
  $("div.events").html(eventsOl)
}

Location.eventListners = function() {
  $("#new_location").on('submit', Location.formSubmit);
  $("a.load_next_location, a.load_previous_location").on("click", Location.clickNavigate);  
  $("a.load_location_events").on("click", Location.clickLoadLocationEvents);  
}

Location.ready = function() {
  Location.eventListners()
}

$(document).on('turbolinks:load', function() {
  Location.ready()
});
