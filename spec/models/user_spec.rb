require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    context 'when it contains proper user info.' do
      it "will pass the test" do
        user = FactoryBot.create(:user)
        expect(user).to be_valid
      end
    end
  end
end
