require "rails_helper"

RSpec.feature "Creating Name" do
  scenario "A user creates a new name" do
    visit "/"

    click_link "New Name"

    fill_in "First name", with: "Adam"
    fill_in "Last name", with: "Alpha"
    click_button "Create Name"

    expect(page).to have_content("The name Adam Alpha has been created")
    expect(page.current_path).to eq(root_path)
  end

  scenario "A user failes to create a new name - First name blank" do
    visit "/"

    click_link "New Name"

    fill_in "First name", with: ""
    fill_in "Last name", with: "Alpha"
    click_button "Create Name"

    expect(page).to have_content("The name Alpha has not been created")
    expect(page).to have_content("First name can't be blank")
    expect(page.current_path).to eq(names_path)
  end

  scenario "A user failes to create a new name - Last name blank" do
    visit "/"

    click_link "New Name"

    fill_in "First name", with: "Adam"
    fill_in "Last name", with: ""
    click_button "Create Name"

    expect(page).to have_content("The name Adam has not been created")
    expect(page).to have_content("Last name can't be blank")
    expect(page.current_path).to eq(names_path)
  end

  scenario "A user failes to create a new name - Both first and last names blank" do
    visit "/"

    click_link "New Name"

    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    click_button "Create Name"

    expect(page).to have_content("The name has not been created")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page.current_path).to eq(names_path)
  end

end
