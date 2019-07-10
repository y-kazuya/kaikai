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

  def refine_user_check(user)
    summary = {}
    user.checks.each do |uc|
      if summary["#{uc.kind}"]
        summary["#{uc.kind}"] << uc
      else
        summary["#{uc.kind}"] = [uc]
      end
    end
    return summary
  end

  def get_week_day(day = Date.today)
    return %w(日 月 火 水 木 金 土)[day.wday]
  end

  def revive_active_record(arr)
    return [] unless arr.length > 0
    arr.first.class.where(id: arr.map(&:id)).with_info
  end
end