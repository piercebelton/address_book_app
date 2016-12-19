require 'rails_helper'

RSpec.feature "AddContacts", type: :feature do
  context 'Landing page' do
    Steps "Going to Landing page" do
      Given 'I visit localhost 3000:' do
        visit '/'
      end
      Then 'I see "Welcome!"' do
        expect(page).to have_content("Welcome!")
      end
    end
  end

  context "Add a contact" do
    Steps "for adding a contact" do
      Given "that I am on the adding contact page" do
        visit "/"
      end
      Then "I can enter contact information" do
        fill_in 'first_name', with: 'Alex'
        fill_in 'last_name', with: 'Smith'
        fill_in 'email', with: '11@chiefs.com'
        fill_in 'address', with: '123 Arrowhead Dr.'
        click_button 'Submit'
      end
      And "I can see all contacts" do
        expect(page).to have_content 'Alex'
        expect(page).to have_content 'Smith'
        expect(page).to have_content '11@chiefs.com'
        expect(page).to have_content '123 Arrowhead Dr.'
      end
      Then "I can update a contact" do
        fill_in 'u_id', with: 'Alex'
        fill_in 'u_first_name', with: 'DeMarcus'
        fill_in 'u_last_name', with: 'Cousins'
        fill_in 'u_email', with: 'boogie@kings.com'
        fill_in 'u_address', with: '789 Kings Place'
        click_button 'Update'
      end
      And "I can see those updates" do
        expect(page).to have_content 'DeMarcus'
        expect(page).to have_content 'Cousins'
        expect(page).to have_content 'boogie@kings.com'
        expect(page).to have_content '789 Kings Place'
      end
      Then "I can destroy a contact" do
        fill_in 'd_id', with: 'DeMarcus'
        click_button 'Destroy'
      end
      And "I can see those updates" do
        expect(page).to_not have_content 'DeMarcus'
        expect(page).to_not have_content 'Cousins'
        expect(page).to_not have_content 'boogie@kings.com'
        expect(page).to_not have_content '789 Kings Place'
      end
    end
  end

  context "I can add a contact that must have a first and last name" do
    Steps "for adding a contact" do
      Given "that I am on the landing page" do
        visit "/"
      end
      Then "I can enter contact information" do
        fill_in 'first_name', with: 'Andy'
        fill_in 'last_name', with: 'Samberg'
        click_button 'Submit'
      end
      And "I can see the information without an e-mail or address" do
        expect(page).to have_content 'Andy'
        expect(page).to have_content 'Samberg'
      end
      Then "I can enter contact information without a first_name" do
        fill_in 'last_name', with: 'Toledo'
        fill_in 'email', with: 'p.toledo@gmail.com'
        fill_in 'address', with: '5 Way'
        click_button 'Submit'
      end
      And "I can see that no contact is created" do
        expect(page).to_not have_content 'Toledo'
        expect(page).to_not have_content 'p.toledo@gmail.com'
        expect(page).to_not have_content '5 Way'
      end
      Then "I can enter contact inforation with a last_name" do
        fill_in 'first_name', with: 'Julian'
        fill_in 'email', with: 'jahoolian@hotmail.com'
        fill_in 'address', with: 'Or The Highway Blvd.'
        click_button 'Submit'
      end
      And "I can see that no contact is created" do
        expect(page).to_not have_content 'Julian'
        expect(page).to_not have_content 'jahoolian@hotmail.com'
        expect(page).to_not have_content 'Or The Highway Blvd.'
      end
    end
  end

  context "I can sort the Contacts list by last name" do
    Steps "for sorting contacts" do
      Given "that I am on the landing page and have 3 contacts" do
        visit "/"
        fill_in 'first_name', with: 'Billy'
        fill_in 'last_name', with: 'Goat'
        click_button 'Submit'

        fill_in 'first_name', with: 'Snoop'
        fill_in 'last_name', with: 'Lion'
        click_button 'Submit'

        fill_in 'first_name', with: 'Drifting'
        fill_in 'last_name', with: 'Zamboni'
        click_button 'Submit'
      end
      Then "I can sort the contacts" do
        click_button 'Sort'
      end
      And "I can see the sorted contacts" do
        expect(page.find('tr:nth-child(2)')).to have_content 'Billy'
        expect(page.find('tr:nth-child(2)')).to have_content 'Goat'
        expect(page.find('tr:nth-child(3)')).to have_content 'Snoop'
        expect(page.find('tr:nth-child(3)')).to have_content 'Lion'
        expect(page.find('tr:nth-child(4)')).to have_content 'Drifting'
        expect(page.find('tr:nth-child(4)')).to have_content 'Zamboni'
      end
    end
  end

  context "I can add phone numbers to contacts" do
    Steps "for adding phone numbers" do
      Given "that I am on the landing page and have 1 contact" do
        visit "/"
        fill_in 'first_name', with: 'Big'
        fill_in 'last_name', with: 'Boi'
        click_button 'Submit'
      end
      Then 'I can add 3 phones to a contact' do
        fill_in 'a_id', with: 'Big'
        fill_in 'a_number', with: '555-5555'
        fill_in 'a_type', with: 'hamburger'
        click_button 'Add'

        fill_in 'a_id', with: 'Big'
        fill_in 'a_number', with: '333-3333'
        fill_in 'a_type', with: 'satellite'
        click_button 'Add'

        fill_in 'a_id', with: 'Big'
        fill_in 'a_number', with: '111-1111'
        fill_in 'a_type', with: 'car'
        click_button 'Add'
      end
      And "I can display all of a contact's number" do
        fill_in 's_id', with: 'Big'
        click_button 'Show'
        expect(page.find('li:nth-child(1)')).to have_content "555-5555"
        expect(page.find('li:nth-child(2)')).to have_content "333-3333"
        expect(page.find('li:nth-child(3)')).to have_content "111-1111"
      end
      Then 'I cannot add more than three numbers to a contact' do
        fill_in 'a_id', with: 'Big'
        fill_in 'a_number', with: '222-2222'
        fill_in 'a_type', with: '100-1001'
        click_button 'Add'

        expect(page).to have_content "Too many numbers!"
      end
    end
  end
end
