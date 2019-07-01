class Public::PagesController < Public::ApplicationController

  def top
    @account = current_account || Account.new
  end
end
