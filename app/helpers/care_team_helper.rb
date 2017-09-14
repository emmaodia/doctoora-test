module CareTeamHelper

	def get_care_team_user care_team_id
		team = CareTeam.find care_team_id
		team_user = User.find team.user_id
		team_username = team_user.first_name + " " + team_user.last_name

		return {id: team.user_id, name: team_username}
	end

	def get_care_team_doctors
	end

end