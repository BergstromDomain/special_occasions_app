require 'rails_helper'
RSpec.describe "Names", type: :request do
  before do
    Name.delete_all
    @adam_alpha = Name.create(first_name: "Adam", last_name: "Alpha")
  end

  describe 'GET /names/:id' do
    context 'with existing name' do
      before { get "/names/#{@adam_alpha.id}" }
      it "handles existing names" do
        expect(response.status).to eq 200
      end
    end
    context 'with non-existing name' do
      before { get "/names/xxxxx" }
      it "handles non-existing names" do
        expect(response.status).to eq 302
        flash_message = "The name you are looking for could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end
