require 'rails_helper'

RSpec.describe Contact, type: :model do
  it 'is a thing' do
    expect{Contact.new}.to_not raise_error
  end

  it 'has first name, last name, email, and address' do
    contact = Contact.new
    contact.first_name = 'Alex'
    contact.last_name = 'Gordon'
    contact.email = '4@royals.com'
    contact.address = '456 Royals Ln.'
    expect(contact.save).to eq true
    c1 = Contact.find_by(first_name: 'Alex', last_name: 'Gordon')
    expect(c1.first_name).to eq 'Alex'
    expect(c1.last_name).to eq 'Gordon'
    expect(c1.email).to eq '4@royals.com'
    expect(c1.address).to eq '456 Royals Ln.'
  end
end
