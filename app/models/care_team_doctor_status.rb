class CareTeamDoctorStatus < ActiveRecord::Base
  belongs_to :care_team
  belongs_to :doctor
end
