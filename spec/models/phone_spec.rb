require 'rails_helper'

RSpec.describe Phone, type: :model do
  it 'is a thing' do
    expect{Phone.new}.to_not raise_error
  end

  it 'has a reference, number, and type' do
    contact = Contact.new(
      first_name: "Ryan",
      last_name: "Reynolds",
      email: "deadpool@marvel.com",
      address: "404 Not Found St."
    )

    phone = Phone.new(
      number: "343-8777",
      phone_type: "cell"
    )

    phone2 = Phone.new(
      number: "222-2222",
      phone_type: "fax"
    )

    contact.phones << phone
    expect(phone.save).to eq true
    contact.phones << phone2
    expect(phone.save).to eq true
    expect(contact.phones[0].number).to eq "343-8777"
    expect(contact.phones[0].phone_type).to eq "cell"
    expect(contact.phones[1].number).to eq "222-2222"
    expect(contact.phones[1].phone_type).to eq "fax"
  end
end
