class DashboardController < ApplicationController
  def index
  end
end
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
  end
end
