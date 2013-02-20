module ApplicationHelper
  def calendar_path_polymorphic(current_user, doctor_id)
    if(current_user.role_type.eql?("Admin") and doctor_id.present?)
      calendar_path(doctor_id: "#{doctor_id}")
    else
      calendar_path
    end
  end

  def new_calendar_time_slot_path_polymorphic(current_user, doctor_id)
    if(current_user.role_type.eql?("Admin") and doctor_id.present?)
      new_calendar_time_slot_path(doctor_id: "#{doctor_id}")
    else
      new_calendar_time_slot_path
    end
  end
end
