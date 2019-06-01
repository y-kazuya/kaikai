module FacilityHelper

  def current_facility
    return false unless current_account
    current_account.facility
  end

  def facility_image(facility, style = :thumb)
    if facility.image.file
      image_tag(facility.image.url)
    else
      "ないよ"
    end
  end
end