# get 'ping', to: 'ping#index'

class PingController < ApplicationController
  layout false
  skip_before_action :authenticate_user!

  def index
    render text: 'OK'
  end
end
