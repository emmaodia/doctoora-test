module VerifyDoctorHelper

	def serve_over_https url
		return "https"+url[4..-1]
	end

	def file_uploaded? file_name
		if file_name != nil
			return true
		else
			return false
		end
	end
end