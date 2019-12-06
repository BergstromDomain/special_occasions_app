require "rails_helper"

RSpec.feature "Showing Name" do
  before do
    Name.delete_all
    @adam_alpha = Name.create(first_name: "Adam", last_name: "Alpha")
    @bertil_bravo = Name.create(first_name: "Bertil", last_name: "Bravo")
    @adam_charlie = Name.create(first_name: "Adam", last_name: "Charlie")
    @cesar_charlie = Name.create(first_name: "Cesar", last_name: "Charlie")
  end

  scenario "A user shows a name" do
    visit "/"
    click_link "#{@adam_alpha.first_name} #{@adam_alpha.last_name}"

    expect(page).to have_content("#{@adam_alpha.first_name} #{@adam_alpha.last_name}")
    expect(page).to have_content(@adam_alpha.created_at.strftime("%d %B, %Y"))
    expect(page).to have_content(@adam_alpha.updated_at.strftime("%d %B, %Y"))
  end
end
