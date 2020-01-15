require "rails_helper"
RSpec.feature "Deleting a Name" do

  before do
    Name.delete_all
    @name = Name.create(first_name: "Adam", last_name: "Alpha")
  end

  scenario "A user deletes a name" do
    visit "/"
    click_link ("#{@name.first_name} #{@name.last_name}")
    click_link "Delete Name"

    expect(page).to have_content("The name #{@name.first_name} #{@name.last_name} has been deleted")
    expect(current_path).to eq(names_path)
  end
end
