class ContactsController < ApplicationController
  def initialize
    @contacts = Contact.all
    @how_many = 0
  end

  def index
    f_name = params[:first_name]
    l_name = params[:last_name]
    email = params[:email]
    address = params[:address]
    if (!f_name.nil? && !l_name.nil? && !email.nil? && !address.nil? &&
       !f_name.strip.empty? && !l_name.strip.empty?)
      @contact = Contact.new(
        first_name: f_name.strip,
        last_name: l_name.strip,
        email: email.strip,
        address: address.strip)

      @contact.save
      flash.now[:right] = 'Added!'
    else
      flash.now[:wrong] = 'Incorrect contact information'
    end
  end

  def update
    id = params[:u_id]
    f_name = params[:u_first_name]
    l_name = params[:u_last_name]
    email = params[:u_email]
    address = params[:u_address]
    c = Contact.find_by_first_name(id)
    if !c.nil?
      if !f_name.nil? && !f_name.strip.empty?
        c.first_name = f_name
      end
      if !l_name.nil? && !l_name.strip.empty?
        c.last_name = l_name
      end
      if !email.nil? && !email.strip.empty?
        c.email = email
      end
      if !address.nil? && !address.strip.empty?
        c.address = address
      end

      c.save
    else
      flash.now[:wrong] = "Please enter correct items for update fields"
    end

    render '/contacts/index'
  end

  def destroy
    id = params[:d_id]
    c = Contact.find_by_first_name(id)
    if !c.nil?
      c.destroy
    else
      flash[:wrong] = "Incorrect ID"
    end

    render '/contacts/index'
  end

  def sort
    @contacts = Contact.order(:last_name).all
    flash.now[:right] = "Sorted!"
    render '/contacts/index'
  end

  def add
    c = Contact.find_by_first_name(params[:a_id])
    num = params[:a_number]
    p_type = params[:a_type]

    if c.nil?
      flash[:wrong] = "Needs Valid Contact Name"
    elsif c.phones.length >= 3
      flash[:wrong] = "Too many numbers!"
    else
      phone = Phone.new(number: num, phone_type: p_type)
      c.phones << phone
      phone.save
      flash[:right] = "Added phone number!"
    end

    render '/contacts/index'
  end

  def show
    c = Contact.find_by_first_name(params[:s_id])
    if !c.nil?
      @nums = c.phones
      @how_many = @nums.length
    else
      flash[:wrong] = "Not Found!"
    end
    render '/contacts/index'
  end
end
