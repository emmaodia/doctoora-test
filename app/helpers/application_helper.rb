module ApplicationHelper

	def get_doctor_name id
		doctor = Doctor.find(id)
		return "Dr. " + doctor.first_name + " " + doctor.last_name
	end

	def get_patient_name id
		patient = User.find(id)
		return patient.first_name + " " + patient.last_name
	end
	
	def greet

		current_time = Time.now.to_i
  		midnight = Time.now.beginning_of_day.to_i
  		noon = Time.now.middle_of_day.to_i
  		five_pm = Time.now.change(:hour => 17 ).to_i
  		eight_pm = Time.now.change(:hour => 20 ).to_i

  		case 
		   when midnight.upto(noon).include?(current_time)
		    return "Good Morning"
		   when noon.upto(five_pm).include?(current_time)
		    return "Good Afternoon"
		   when five_pm.upto(eight_pm).include?(current_time)
		    return "Good Evening"
		   when eight_pm.upto(midnight + 1.day).include?(current_time)
		    return "Good Night"
		end
	end

end
