class Public::UsersController < Public::ApplicationController

  def index
    @users = current_facility.users
  end

  def new
    @user = User.new

    @user.emergency_contacts.build
    @user.notes.build
    @user.user_checks.build
    # @note_categories = NoteCategory.where("(public = ?) OR (facility_id = ?)", true, current_facility.id)
  end

  def create
    @user = User.new(user_params)
    @user.facility_id = current_facility.id
    if @user.save
      flash[:info] = "ユーザーの登録に成功しました"

      redirect_to account_users_path(current_account)
    else
      flash[:warning] = "フォームに誤りがあります"
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @user.emergency_contacts.build if @user.emergency_contacts == []
    @user.notes.build if @user.notes == []
    @user.user_checks.build if @user.user_checks == []
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を編集しました"
      redirect_to account_user_path(current_account, @user.id)
    else
      render 'show'
    end
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:name, :sex, :image,:care_level,:birth_day,
                                  :birth_year,:birth_month,:age,
                                  :use_mon, :use_tue, :use_wed, :use_thu,
                                  :use_fri, :use_sat, :use_sun,:use_random,
                                  { :check_ids => [] },
                                  emergency_contacts_attributes: [:id, :name, :relation, :email, :tel, :pref,
                                                                   :city, :address],
                                  notes_attributes: [:id, :image, :content, :note_category_id],

                                  )
    end



end
