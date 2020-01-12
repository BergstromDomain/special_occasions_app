require "rails_helper"
RSpec.feature "Editing Name" do
  before do
    Name.delete_all
    @name = Name.create(first_name: "Adam", last_name: "Alpha")
  end

  scenario "A user edits a name" do
    visit "/"
    click_link ("#{@name.first_name} #{@name.last_name}")

    click_link "Edit Name"
    fill_in "First name", with: "Bertil"
    fill_in "Last name", with: "Bravo"
    click_button "Update Name"

    expect(page).to have_content("The name #{@name.first_name} #{@name.last_name} has been updated")
    expect(page).to have_content("Bertil Bravo")
    expect(page.current_path).to eq(name_path(@name))
  end

  scenario "A user fails to edit a name - Both first and last names blank" do
    visit "/"
    click_link ("#{@name.first_name} #{@name.last_name}")

    click_link "Edit Name"
    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    click_button "Update Name"

    expect(page).to have_content("The name #{@name.first_name} #{@name.last_name} has not been updated")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page.current_path).to eq(name_path(@name))
  end
end
