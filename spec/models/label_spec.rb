require 'rails_helper'

RSpec.describe Label, type: :model do
  it 'will produce a valid label' do
    expect(FactoryBot.create(:label)).to be_valid
  end
  context 'new label has been created ' do
    it 'will still be valid' do
      label = FactoryBot.create(:label)
      label = Label.new(name: 'Work')
      expect(label).to be_valid
    end
  end
end