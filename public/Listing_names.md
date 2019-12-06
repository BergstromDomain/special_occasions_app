Listing Names
==================================================


## Table of Content
1. [Create git feature branch](#create-git-feature-branch)
2. [Create RSpec feature specification with successful scenario](#create-rspec-feature-specification-with-successful-scenario)
  1. [Update create action of the controller](#update-create-action-of-the-controller)
3. [Commit changes and merge into master branch](#commit-changes-and-merge-into-master-branch)


## Create a feature branch
Create a git feature branch.
```bash
git checkout -b listing-name
```

## Create feature specification with successful scenario
Create a new file called _listing_name_spec.rb_ and make sure it starts with the line `require "rails_helper"`. Add the steps and the expected results from the actions.
```ruby
require "rails_helper"
RSpec.feature "Listing Names" do
  before do
    @adam_alpha = Name.create(first_name: "Adam", last_name: "Alpha")
    @bertil_bravo = Name.create(first_name: "Bertil", last_name: "Bravo")
    @adam_charlie = Name.create(first_name: "Adam", last_name: "Charlie")
    @cesar_charlie = Name.create(first_name: "Cesar", last_name: "Charlie")
  end

  scenario "A user lists all names" do
    visit "/"

    adam_alpha_full_name = "#{@adam_alpha.first_name} #{@adam_alpha.last_name}"
    expect(page).to have_content(adam_alpha_full_name)
    expect(page).to have_link(adam_alpha_full_name)

    bertil_bravo_full_name = "#{@bertil_bravo.first_name} #{@bertil_bravo.last_name}"
    expect(page).to have_content(bertil_bravo_full_name)
    expect(page).to have_link(bertil_bravo_full_name)

    adam_charlie_full_name = "#{@adam_charlie.first_name} #{@adam_charlie.last_name}"
    expect(page).to have_content(adam_charlie_full_name)
    expect(page).to have_link(adam_charlie_full_name)

    cesar_charlie_full_name = "#{@cesar_charlie.first_name} #{@cesar_charlie.last_name}"
    expect(page).to have_content(cesar_charlie_full_name)
    expect(page).to have_link(cesar_charlie_full_name)    
  end
end
```

Run RSpec and address each error as they occur.
```bash
rspec spec/features/listing_name_spec.rb
```

### Update the create action of the controller
Update the `create` action for the controller.
```ruby
def create
  @name = Name.new(name_params)
  @name.full_name = "#{@name.first_name} #{@name.last_name}"
  if @name.save
    flash[:sucess] = "The name #{@name.full_name} has been created"
    redirect_to root_path
  else
    flash.now[:danger] = "The name #{@name.full_name} has not been created"
    render :new
  end
end
```

### Update the index view
Update the `create` action for the controller. __Note__ Using _full_name_ worked fine in _Rails_ but _Capybara_ could not found the link. Therefore use _first_name_ and _last_name_ as seen below.
```ruby
<%= link_to "New Name", new_name_path, class: "btn btn-primary btn-lg"%>

<% @names.each do |name| %>
  <div class="full-name">
    <%= link_to "#{name.first_name} #{name.last_name}", name_path(name) %>
  </div>
<% end %>
```

## Commit the changes and merge into master branch
Check the _Git_ status and commit the updated files.
```bash
git status
git add -A
git commit -m "Implementing listing name functionality"
```

Checkout the _master_ branch and merge the changes.
```bash
git checkout master
git merge listing-name
git push
```

View a colourful log of the git branches and the commits.
```bash
git log --graph --oneline --decorate  
```
