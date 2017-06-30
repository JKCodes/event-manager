module ParticipantsHelper
  def participant_to_s(participant)
    full_name = "#{participant.first_name} #{participant.last_name}"
    full_name == " " ? "#{participant.nickname}" : full_name + "(#{participant.nickname})"
  end

end
