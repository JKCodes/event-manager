class ParticipantsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :create_participant, only: [:new]
  before_action :set_participant, only: [:show, :edit, :update, :destroy]

  private
    def create_participant
      @participant = current_user.participants.build
    end

    def set_participant
      @participant = Participant.by_user(current_user).find(params[:id])
    end

    def participant_params
      params.require(:participant).permit(:name, :street_address, :city, :state, :zipcode)
    end
end
