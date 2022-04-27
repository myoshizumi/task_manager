# frozen_string_literal: true

# == Schema Information
#
# Table name: labels
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Label, type: :model do
  it 'will produce a valid label' do
    expect(FactoryBot.create(:label)).to be_valid
  end
  context 'new label has been created ' do
    it 'will still be valid' do
      FactoryBot.create(:label)
      label = Label.new(name: 'Work')
      expect(label).to be_valid
    end
  end
end
