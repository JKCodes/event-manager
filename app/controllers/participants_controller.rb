class ParticipantsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :create_participant, only: [:new]
  before_action :set_participant, only: [:show, :edit, :update, :destroy]

  def index
    @participants = Participant.by_user(current_user)
  end

  def create
    @participant = current_user.participants.build(participant_params)

    if @participant.save
      redirect_to participants_path, notice: "Participant was created successfully"
    else
      render :new
    end
  end

  def update
    if @participant.update(participant_params)
      redirect_to participant_path(@participant), notice: "Participant was updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @participant.destroy
    redirect_to participants_path, notice: "Participant was deleted successfully"
  end

  private
    def create_participant
      @participant = current_user.participants.build
    end

    def set_participant
      @participant = Participant.by_user(current_user).find(params[:id])
    end

    def participant_params
      params.require(:participant).permit(:nickname, :first_name, :last_name, :email, :phone_number)
    end
end
