class Public::UsersController < Public::ApplicationController

  before_action -> {
    check_auth_account_info(params[:account_id])
  }



  def index
    @users = current_facility.users.with_info
  end

  def new
    @user = User.new
    @unique_checks = Check.where("(common = ?) AND ((public = ?) OR (facility_id = ?))", false,true, current_facility.id)
    @common_checks = Check.where("((common = ?) AND (public = ?)) OR ((common = ?) AND (facility_id = ?)) ", true,true,true ,current_facility.id)
    @user.emergency_contacts.build
    @user.notes.build
    @user.user_checks.build
    # @note_categories = NoteCategory.where("(public = ?) OR (facility_id = ?)", true, current_facility.id)
  end

  def create
    @user = User.new(user_params)
    @unique_checks = Check.where("(common = ?) AND ((public = ?) OR (facility_id = ?))", false,true, current_facility.id)
    @common_checks = Check.where("((common = ?) AND (public = ?)) OR ((common = ?) AND (facility_id = ?)) ", true,true,true ,current_facility.id)
    @user.facility_id = current_facility.id
    if @user.save
      flash[:info] = "ユーザーの登録に成功しました"

      redirect_to account_users_path(current_account)
    else
      flash[:warning] = "フォームに誤りがあります"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @unique_checks = Check.where("(common = ?) AND ((public = ?) OR (facility_id = ?))", false,true, current_facility.id)
    @common_checks = Check.where("((common = ?) AND (public = ?)) OR ((common = ?) AND (facility_id = ?)) ", true,true,true ,current_facility.id)
    @user.emergency_contacts.build if @user.emergency_contacts == []
    @user.notes.build if @user.notes == []
    @user.user_checks.build if @user.user_checks == []
  end

  def show
    @user = User.find(params[:id])
    @number_checks = @user.checks.where(kind: 2)
    check_auth_account_info(@user.facility.account.id)
  end

  def update
    @user = User.find(params[:id])
    @unique_checks = Check.where("(common = ?) AND ((public = ?) OR (facility_id = ?))", false,true, current_facility.id)
    @common_checks = Check.where("((common = ?) AND (public = ?)) OR ((common = ?) AND (facility_id = ?)) ", true,true,true ,current_facility.id)

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
