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
		end

		send_doctor_care_team_request care_team.id, params[:doctor_id]
		# care_team.doctor_ids << params[:doctor_id]
		# if care_team.save
		# 	flash[:notice] = "Doctor successfully added to your care team"
		# 	redirect_to care_path
		# else
		# 	flash[:notice] = "Doctor could not be added to care team"
		# 	redirect_to care_path
		# end
	end

	def doctors
		@care_team_requests = CareTeamDoctorStatus.where('joined = false AND doctor_id = params[:doctor_id')
	end

	private

	def send_doctor_care_team_request care_team_id, doctor_id
		care_team = CareTeamDoctorStatus.new(care_team_id: care_team_id, doctor_id: doctor_id, joined: false)

		if care_team.save
			flash[:notice] = "Your Care Team Request has been successfully sent"
			notify! current_user.id, doctor_id, notification: "New care team request sent"
		end
	end
end