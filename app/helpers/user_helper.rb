module UserHelper


  def user_image(user, style = :thumb)
    if user.image.file
      image_tag(user.image.url)
    else
      "ないよ"
    end
  end
end