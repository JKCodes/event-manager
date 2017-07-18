function Event(attributes) {
  this.id = attributes.id === null ? "" : attributes.id
  this.name = attributes.name === null ? "" : attributes.name
}

$(document).on('turbolinks:load', function() {

  // Event show participants
  $("a.load_participants").on("click", function(e) {
    e.preventDefault();

    $.get(this.href).success(function(json) {
      $("a.load_participants").hide()

      var $participants = $("div.participants")
      var html = "<ol>"

      json.forEach(function(participant) {
        html += `<li><a href="/participants/${participant.id}">${participant.nickname}</a></li>`
      })

      html += "</ol>"

      $participants.html(html)
    });
  });  
});
