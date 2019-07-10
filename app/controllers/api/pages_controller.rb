class Api::PagesController < ApplicationController

  def create_contact
    @contact = Contact.new(contact_params)


    respond_to do |format|
      if @contact.save
        flash.now[:success] = "送信いたしました。ありがとうございます"
        format.js {}
      else
        flash.now[:warning] = "フォームを全て埋めてください"
        format.js { render "shared/flash.js.erb" }
      end

    end

  end

  private
  def contact_params

    params.require(:contact).permit(:name, :email, :content,:kind)
  end
end
