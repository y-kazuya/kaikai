class Public::PagesController < Public::ApplicationController

  def top
    @account = current_account || Account.new
  end

  def contact
    @contact = Contact.new
  end

  def policy
  end

  def about
  end
end
