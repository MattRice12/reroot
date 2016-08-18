class MembersController < ApplicationController
  def create
    Member.create!(member_params)
  end

  private

  def member_params
    params.require(:member).permit(:user_id, :team_id)
  end
end
