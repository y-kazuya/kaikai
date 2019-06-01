class Public::FacilitiesController < Public::ApplicationController

  def show
    @facility = current_facility
  end

  def update
    @facility = current_facility
    if @facility.update_attributes(facility_params)
      flash[:success] = "施設情報を編集しました"
      redirect_to account_facilities_path(@facility)
    else
      render 'show'
    end
  end

  private

  def facility_params
    params.require(:facility).permit(:name,
                                     :image,
                                     :tel,
                                     :email,
                                     :url,
                                     :pref,
                                     :city,
                                     :address
                                     )
  end
end
