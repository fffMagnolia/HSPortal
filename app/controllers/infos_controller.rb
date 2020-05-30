class InfosController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show, :destroy]
  # bug
  before_action :owner?, only: [:new, :create, :destroy]

  def new
  end

  def create
  end

  def show
    @info = Info.find(params[:id])
  end

  def destroy
  end

  private

    def info_params
    end
end
