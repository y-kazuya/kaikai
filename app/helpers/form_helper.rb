module FormHelper

  def preview_picture_image(contet)
    if contet.image_url
      return contet.image_url
    else
      return "common/place_picture.png"
    end

  end

end