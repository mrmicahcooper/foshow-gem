# Foshow

Foshow allows you to display the application code in your rails application.

I use it for presentations where I don't want to make slides and or switch back and forth between my application and my code. This allows me to have a working app, and display the code it took to create it, right next to it. It can be very usefull for introducing new ideas to people.


## Installation

Add this line to your application's Gemfile:

    gem 'foshow'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install foshow

Then install the javascript and css files to make it look a little better:

    $ rails generate foshow:install

## Usage

###Default - Rails conventions
This gem only works with rails apps and assumes you are following rails basic MVC naming conventions.
For example, a model named "user" has a controller named "app/controllers/users_controller.rb" and a view directory called "app/views/users/"

All you have to do is add this to (the bottom of) your application layout ('apps/views/layouts/application.html.haml').

    # Add to 'app/views/layouts/application.haml'

    Foshow.render(self)



This, by default, displays the code for the model, view, and controller of the resource you're viewing so long as they exist.

###Configurating beyond the defaults
If you want to display more code for a page, do it here: 'config/initializers/foshow.rb'

To display more code for a resource(page) configure Foshow with a block.

It's kinda like your routes file. Observe:

	# Use a Hash to specify what controller#action will display the files given.
	# Use just an Array to make the files display on all controller#actions.

	Foshow.configure do |config|
		config.views = { 'controller#action_name' => ['app/views/controller/other_file_name.html.erb']}
		config.javascripts = ['app/assets/javascripts/global.js']
	end

	# the methods called on config will become links to display that section in your application layout.

__note__: The file paths must always be in an array. They will not render otherwise.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

##To do
- Add more tests

##Thank you
shayarnett
