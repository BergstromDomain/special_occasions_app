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
