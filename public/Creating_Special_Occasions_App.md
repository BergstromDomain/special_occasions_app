Creating the Special Occasions App
==================================================
Creating the application and setting up the development environment

## Table of Content
1. [Creating the Special Occasions App](#creating-the-special-occasion-app)
2. [RSpec and Capybara](#rspec-and-capybara)
3. [Guard](#guard)
4. [Bootstrap](#bootstrap)
5. [Git](#git)


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

## Bootstrap
### Installing Bootstrap
In the Gemfile add the following gems:
```ruby
gem 'bootstrap-sass', '~> 3.4', '>= 3.4.1'
gem 'autoprefixer-rails', '~> 9.7', '>= 9.7.2'
```
Run `bundle install`

Create a new file _app/assets/stylesheets/custom.css.scss_ and add the following to it:
```css
@import "bootstrap-sprockets";
@import "bootstrap";
```

Update the file _app/assets/javascripts/application.js_ by adding the line
```java script
//= require bootstrap-sprockets
```


##  Git
###  Initializing the Git Repository
```bash
git init
git status
git add -A
git commit -m "Initializing Special Occasions App and setting up the environment"
```

### Pushing repository to GitHub
From GitHub, copy the URL and paste it on the command line to push your existing repository GitHub
```bash
git remote add origin git@github.com:BergstromDomain/special_occasions_app.git
git push -u origin master
git remote -v
```
