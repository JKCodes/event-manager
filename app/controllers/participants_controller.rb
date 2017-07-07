class ParticipantsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :create_participant, only: [:new]
  before_action :set_participant, only: [:show, :edit, :update, :destroy]
  before_action :set_event, only: [:index]


  def index
    @participants = Participant.by_user(current_user)

    if request.xhr? != 0
      render "index"
    else
      render json: @event.participants if @event
    end
  end

  def create
    @participant = current_user.participants.build(participant_params)

    if @participant.save
      redirect_to participants_path, notice: "Participant was created successfully"
    else
      render :new
    end
  end

  def show
    set_previous_participant(@participant)
    set_next_participant(@participant)
    set_participant_indexes(@participant)
    if request.xhr? != 0
      render "show"
    else
      render json: @participant
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
    def set_previous_participant(participant)
      @previous = Participant.previous(participant)
    end

    def set_next_participant(participant)
      @next = Participant.next(location)
    end

    def set_location_indexes(participant)
      @indexes = Participant.indexes(participant)
    end

    def create_participant
      @participant = current_user.participants.build
    end

    def set_participant
      @participant = Participant.by_user(current_user).find(params[:id])
    end

    def participant_params
      params.require(:participant).permit(:nickname, :first_name, :last_name, :email, :phone_number)
    end

    def set_event
      @event = Event.by_user(current_user).find(params[:event_id]) if params[:event_id]
    end
end
