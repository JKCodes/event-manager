# Event Manager

## Overview

Event Manager allows users to create/read/update/delete various events.  Users can only view events that are associated with them.  Creator of an event will automatically have read/update/delete privileges for that event.  All other users for that event will only have read privileges.  Users must be logged in to use Event Manager.  If not logged in, only the welcome page, sign up page, and login page are accessible.  If a user visits any other pages, that uers will be redirected to the login page.  

## Installation and Usage

1. Change directory to wherever event-manager is located on your drive
2. Run bundle install
```
bundle install
```
3. Note that this repo does not contain .env file for Facebook Login or secrets.yml file.  You will need to set up your own database and input your Facebook Login keys inside .env file.
4. Run the server
```
rails server
``` 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JKCodes/event-manager. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
