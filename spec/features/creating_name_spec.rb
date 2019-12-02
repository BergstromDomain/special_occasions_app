require "rails_helper"

RSpec.feature "Creating Name" do
  scenario "A user creates a new name" do
    visit "/"

    click_link "New Name"

    fill_in "First name", with: "Adam"
    fill_in "Last name", with: "Alpha"
    click_button "Create Name"

    expect(page).to have_content("The name has been created")
    expect(page.current_path).to eq(root_path)
  end
end
