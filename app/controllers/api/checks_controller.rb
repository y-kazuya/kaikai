class Api::ChecksController < ApplicationController

  def create
    title = params[:title]
    kind = params[:kind].to_i

    @check = Check.new(title: title, kind: kind,facility_id: current_facility.id, public: false)
    @check.save

    respond_to do |format|
        format.json {render :json => @check}
    end
  end
end
