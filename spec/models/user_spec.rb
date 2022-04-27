# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admin           :boolean          default(FALSE), not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    context 'when it contains proper user info.' do
      it 'will pass the test' do
        user = FactoryBot.create(:user)
        expect(user).to be_valid
      end
    end
  end
end
