class Public::EventsController < Public::ApplicationController
  before_action -> {
    check_auth_account_info(params[:account_id])
  }

  def index
  end

  def new
    @event = Event.new
  end

  def create
  end

  def show
  end

  def update
  end

  def destory

  end
end
