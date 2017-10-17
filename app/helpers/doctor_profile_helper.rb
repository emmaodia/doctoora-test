module DoctorProfileHelper

	def doc_file_uploaded? file_name
		if file_name != nil
			return "Uploaded!"
		else
			return "Missing"
		end
	end

end