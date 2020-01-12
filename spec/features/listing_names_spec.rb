require "rails_helper"
RSpec.feature "Listing Names" do
  before do
    Name.delete_all
    @adam_alpha = Name.create(first_name: "Adam", last_name: "Alpha")
    @bertil_bravo = Name.create(first_name: "Bertil", last_name: "Bravo")
    @adam_charlie = Name.create(first_name: "Adam", last_name: "Charlie")
    @cesar_charlie = Name.create(first_name: "Cesar", last_name: "Charlie")
  end

  scenario "A user lists all names" do
    visit "/"

    expect(page).to have_content("#{@adam_alpha.first_name} #{@adam_alpha.last_name}")
    expect(page).to have_link("#{@adam_alpha.first_name} #{@adam_alpha.last_name}")

    expect(page).to have_content("#{@bertil_bravo.first_name} #{@bertil_bravo.last_name}")
    expect(page).to have_link("#{@bertil_bravo.first_name} #{@bertil_bravo.last_name}")

    expect(page).to have_content("#{@adam_charlie.first_name} #{@adam_charlie.last_name}")
    expect(page).to have_link("#{@adam_charlie.first_name} #{@adam_charlie.last_name}")

    expect(page).to have_content("#{@cesar_charlie.first_name} #{@cesar_charlie.last_name}")
    expect(page).to have_link("#{@cesar_charlie.first_name} #{@cesar_charlie.last_name}")
  end
end
