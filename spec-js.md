# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements
- [ ] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend.
  + Plan: Allow users to see previous/next event/participant/location on their respective show page without reloading
- [ ] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend.
  + Plan: This required will be fulfilled by the has_many requirement
- [ ] Include at least one has_many relationship in information rendered via JSON and appended to the DOM.
  + Plan
    = Do not automatically display events on location/participant show page
    = Do not automatically display participants on events show page
- [ ] Use your Rails API and a form to create a resource and render the response without a page refresh.
  + Plan: Allow users to directly create Participant and Location on index page using nickname/name that does not refresh the page.  Leave the link just in case if a user wants to create a more detailed participant and location.  
- [ ] Translate JSON responses into js model objects.
  + Plan: Make sure all responses use a js model objects
- [ ] At least one of the js model objects must have at least one method added by your code to the prototype.
  + Plan: Refactoring the above requirements should automatcially fulfill this requirement

Confirm
- [ ] You have a large number of small Git commits
- [ ] Your commit messages are meaningful
- [ ] You made the changes in a commit that relate to the commit message
- [ ] You don't include changes in a commit that aren't related to the commit message