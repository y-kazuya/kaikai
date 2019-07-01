module UserHelper


  def user_image(user, style = :thumb)
    if user.image.file
      image_tag(user.image.url)
    else
      "ないよ"
    end
  end

  def get_use_weeks(user)
    summary = []
    User.weeks.each do |key, value|
      te = eval "user.use_#{value}"
      summary << key if te
    end
    return summary.join("、")
  end

  def refine_user_note(user)

    summary = {}
    user.notes.each do |un|
      if summary["#{un.note_category.name}"]
        summary["#{un.note_category.name}"] << un
      else
        summary["#{un.note_category.name}"] = [un]
      end
    end
    return summary
  end
end