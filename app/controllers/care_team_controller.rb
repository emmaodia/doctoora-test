class CareTeamController < ApplicationController

	def new_search
		@care_team_doctors = []
		if current_user.care_team
			CareTeam.find_by_user_id(current_user.id).doctor_ids.each do |doctor_id|
				@care_team_doctors << Doctor.find(doctor_id)
			end
		end
	end

	def search_results
		@doctors = Doctor.search(params[:location], params[:specialization])
	end

	def add_doctor
		care_team = CareTeam.find_by_user_id current_user.id
		if care_team == nil
			care_team = CareTeam.new(user_id: current_user.id)
			care_team.save
		end

		send_doctor_care_team_request care_team.id, params[:doctor_id]
		redirect_to care_path
	end

	def doctor
		@care_team_requests = CareTeamDoctorStatus.where("joined = ? AND doctor_id = ?", false, params[:id])
	end

	def accept_care_team_request
		care_team_request = CareTeamDoctorStatus.find params[:request_id]
		care_team_request.joined = true
		care_team_request.save

		care_team = CareTeam.find care_team_request.care_team_id
		care_team.doctor_ids << current_doctor.id
		care_team.save
		
		flash[:notice] = "You have successfully accepted the care team request"
		notify! care_team.user_id, current_doctor.id, "New doctor added to your care team"
		redirect_to doctor_care_team_path(current_doctor)
	end

	def reject_care_team_request
		flash[:notice] = "You have successfully rejected the care team request"
		notify! care_team.user_id, current_doctor.id, "Unfortunately doctor has rejected your care team request"
		redirect_to doctor_care_team_path(current_doctor)
	end

	private

	def send_doctor_care_team_request care_team_id, doctor_id
		care_team_req = CareTeamDoctorStatus.new(care_team_id: care_team_id, doctor_id: doctor_id, joined: false)

		if care_team_req.save
			flash[:notice] = "Your Care Team Request has been successfully sent"
			notify! current_user.id, doctor_id, notification: "New care team request sent"
		end
	end
end