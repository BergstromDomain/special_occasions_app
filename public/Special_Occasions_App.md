Special Occasions App
==================================================

##  Creating the Special Occasions App
Move to the working directory and create a new application. Use the `-T` flag to skip the testing framework in order to use _RSpec_
```bash
rails new special_occasions_app -T
```
Move to the application folder and run the _Bundler_ to install the _gems_
```bash
cd special_occasions_app
bundle install
```
Start the server
```bash
rails server
```

View the local application in your browser `http://localhost:3000/`

##  Git
###  Initializing the Git Repository
```bash
git init
git status
git add -A
git commit -m "Initializing Lifestyle Events App"
```

### Pushing repository to GitHub
From GitHub, copy the URL and paste it on the command line to push your existing repository GitHub
```bash
git remote add origin git@github.com:BergstromDomain/lifestyle_events_app.git
git push -u origin master
git remote -v
```

##  RSpec and Capybara
###  Installing RSpec and Capybara
Install _RSpec_
```bash
sudo apt install ruby-rspec-core
```
Add _RSpec_ and _Capybara_ to the _Gemfile_
```ruby
group :development, :test do
  gem 'rspec-rails', '~> 3.9'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'capybara', '~> 3.29'
end
```
Run the _Bundler_ to install the new gems
```bash
bundle install
```

### Adding RSpec to the project
Run the generator to install _RSpec_ to the project
```bash
rails generate rspec:install
```
Generate an RSpec stub for the project
```bash
bundle binstubs rspec-core
```
Create a _feature_ folder under the _spec_ folder
```bash
mkdir spec/features
```

## Guard
### Adding Guard to the project
Add _Guard_ gems to the _Gemfile_
```ruby
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'guard', '~> 2.14.0'
  gem 'guard-rspec', '~> 4.7.2'
  gem 'guard-cucumber', '~> 2.1.2'
end
```

Run the _Bundler_ to install the new _gems_
```bash
bundle install
```

Initialize _Guard_ with the command:
```bash
guard init
```

Generate an Guard stub for the project
```bash
bundle binstubs guard
```

Initialize _Cucumber_ with the command:
```bash
cucumber --init
```

Update the _Guardfile_ by adding watches under the _Rails files_, _Rails config changes_ and _Capybara features specs_
```ruby
# Rails files
rails = dsl.rails(view_extensions: %w(erb haml slim))
dsl.watch_spec_files_for(rails.app_files)
dsl.watch_spec_files_for(rails.views)

watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { "spec/features" }
watch(%r{^app/models/(.+)\.rb$})  { "spec/features" }
watch(rails.controllers) do |m|
  [
    rspec.spec.call("routing/#{m[1]}_routing"),
    rspec.spec.call("controllers/#{m[1]}_controller"),
    rspec.spec.call("acceptance/#{m[1]}")
  ]
end

# Rails config changes
watch(rails.spec_helper)     { rspec.spec_dir }
watch(rails.routes)          { "spec" } # { "#{rspec.spec_dir}/routing" }
watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

# Capybara features specs
watch(rails.view_dirs)     { "spec/features" } # { |m| rspec.spec.call("features/#{m[1]}") }
watch(rails.layouts)       { |m| rspec.spec.call("features/#{m[1]}") }
```


## CRUD Event Types
### Create Lifestyle Event Types
Create a topic branch
```bash
git checkout -b creating-lifestyle-event-types
```
#### Create feature specification
Create a new file called _creating_event_types_spec.rb_ and make sure it starts with the line `require "rails_helper"`
```ruby
require "rails_helper"

RSpec.feature "Creating Lifestyle Event Types" do
  scenario "A user creates a new event type" do
    visit "/"

    click_link "New Lifestyle Event Type"

    fill_in "Name", with: "Birthday"
    click_button "Create Lifestyle Event Type"

    expect(page).to have_content("Lifestyle Event Type has been created")
    expect(page.current_path).to eq(event_types_path)
  end
end
```
#### Run RSpec and address errors
```bash
rspec spec/features/creating_lifestyle_event_types_spec.rb
```

#### Update the route file
Create a _root path_ by updating the _config/routes.rb_ file
```ruby
root to: "lifestyle_event_types#index"
```
Create the required resources by updating the _config/routes.rb_ file
```ruby
resources :lifestyle_event_types
```

#### Generate the controller
Use a generator to create a controller
```bash
rails g controller lifestyle_event_types index
```

#### Create the index view
Create the file _app/views/lifestyle_event_types/index.html.erb_ and add the link to _New Lifestyle Event Types_
```ruby
<%= link_to "New Lifestyle Event Type", new_lifestyle_event_type_path, class: "btn btn-default btn-lg", id: "new-lifestyle-event-type-btn" %>
```

#### Update the route file
Add `resources` to the _config/routes.rb_ file
```ruby
resources :lifestyle_event_types
```

#### Add the new action to the controller
Add the `new` action for the controller
```ruby
def new
  @lifestyle_event_type = LifestyleEventType.new
end
```

#### Create the new view
Create the file _app/views/lifestyle_event_types/new.html.erb_
```ruby
<h3 class="text-center">Adding New Lifestyle Event Type</h3>
<div class="row">
  <div class="col-md-12">
    <%= form_for(@lifestyle_event_type, :html => {class: "form-horizontal", role: "form"}) do |f| %>
      <div class="form-group">
        <div class="control-label col-md-1">
          <%= f.label :title %>
        </div>
        <div class="col-md-11">
          <%= f.text_field :title, class: "form-control", placeholder: "Title of lifestyle event type", autofocus: true %>
        </div>
      </div>
      <div class="form-group">
        <div class="col-md-offset-1 col-md-11">
          <%= f.submit "Create Lifestyle Event Type", class: "btn btn-primary btn-lg pull-right" %>
        </div>
      </div>
    <% end %>
  </div>
</div>
```

#### Generate model
Use a generator to create a model. __Note__ the model is singular and the controller is plural
```bash
rails g model lifestyle_event_type title:string
```

#### Run the migration
Run the migration to create a database
```bash
rails db:migrate
```

#### Add the create action to the controller
Add the `create` action for the controller as well as the __private__ `lifestyle_event_type_params` method
```ruby
def create
  @lifestyle_event_type = LifestyleEventType.new(lifestyle_event_type_params)
  if @lifestyle_event_type.save
    flash[:sucess] = "The lifestyle event type has been created"
    redirect_to lifestyle_event_types_path
  else
    flash.now[:danger] = "The lifestyle event type has not been created"
    render :new
  end
end

private
  def lifestyle_event_type_params
    params.require(:lifestyle_event_type).permit(:title)
  end
```
#### Add flash to the application
Update the file _app/views/layouts/application.html.erb_ to add flash to the application
```ruby
<% flash.each do |key, message| %>
  <div class="text-center alert alert-<%= key == 'notice'? 'success': 'danger' %>">
    <%= message %>
    </div>
<% end %>
```
#### Add Bootstrap for styling
In the Gemfile add the following gems:
```ruby
gem 'bootstrap-sass', '~> 3.4', '>= 3.4.1'
gem 'autoprefixer-rails', '~> 9.7', '>= 9.7.2'
```
Run `bundle install`

Create a new file _app/assets/stylesheets/custom.css.scss_ and add the following to it:
@import "bootstrap-sprockets";
@import "bootstrap";

Update the file _app/assets/javascripts/application.js_ by adding the line
```java script
//= require bootstrap-sprockets
```

#### Add a navigation bar
Edit the file _app/views/layouts/application.html.erb_ and add a navigation bar in the body tag:
```ruby
<body>
  <header role="banner">
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse"
          data-target="#bs-example-navbar-collapse-1">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <%= link_to "Niklas", root_path, class: "navbar-brand" %>
      </div>
      <div class="navbar-collapse collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
          <li class="active"><%= link_to "Lifestyle Events App", root_path %></li>
        </ul>
      </div>
    </div>
  </nav>
</header>
<div class="container">
  <div class="row">
    <div class="col-md-12">
      <% flash.each do |key, message| %>
      <div class="text-center alert alert-<%= key == 'notice'? 'success': 'danger' %>">
        <%= message %>
      </div>
      <% end %>
      <%= yield %>
    </div>
  </div>
</div>
</body>
```
__Note:__ This caused the error: `ExecJS::ProgramError in LifestyleEventTypes#index
identifier '(function(opts, pluginOpts) {return eval(process' undefined
`
![Error message](public/images/Rails_Error_-_ExecJS.png)
The solution I used was to comment out the `duktape` gem from the _Gemfile_

#### Adding validation
Update the file _models/lifestyle_event_type.rb_ to include validation and sort order
```ruby
validates :title, presence: true
default_scope { order(created_at: :desc) }

```

##  Configure RSpec

####################################################################################################
##  Configure RSpec
####################################################################################################

# Update .rspsec
--color
--require spec_helper
--format progress
--no-profile
--no-fail-fast
--order defined



####################################################################################################
##  Add the resources to the routes.rb file
####################################################################################################

Rails.application.routes.draw do
  root to: "lifestyle_events#index"

  resources :lifestyle_events
end


####################################################################################################
##  Generating the Lifestyle Event Model
####################################################################################################

rails generate model lifestyle_event name:string date:string type:string




####################################################################################################
##  Add create action to the controller
####################################################################################################

def create
  @lifestyle_event = LifestyleEvent.new(lifestyle_event_params)
  @lifestyle_event.save
  flash[:success] = "Lifestyle event has been created"
  redirect_to lifestyle_events_path
end

#  Add flah message to the application



####################################################################################################
##  Adding styling with Bootstrap
####################################################################################################

# Update Gemfile
# Add gem bootstrap-sass
# Add gem autoprefixer-rails

bundle install


####################################################################################################
##  Creating a custom.css.scss stylesheet file
####################################################################################################

@import "bootstrap-sprockets";
@import "bootstrap";


####################################################################################################
##  Copy a navbar template from Bootstrap
####################################################################################################

# Add the navigation bar to application.html.erb

s
