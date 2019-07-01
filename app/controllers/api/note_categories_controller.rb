class Api::NoteCategoriesController < ApplicationController

  def index
    @note_categories = NoteCategory.where("(public = ?) OR (facility_id = ?)", true, current_facility.id).to_json()
    respond_to do |format|
      format.json {render :json => @note_categories}
    end
  end

  def create
    name = params[:name]
    @note_category = NoteCategory.new(name: name, facility_id: current_facility.id, public: false)
    @note_category.save

    respond_to do |format|
        format.json {render :json => @note_category}
    end
  end
end
