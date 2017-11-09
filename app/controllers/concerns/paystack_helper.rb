module PaystackHelper

	def initialize_transaction amount, email

		amount_in_kobo = amount*100

		body = {
			"amount" => amount_in_kobo.to_s,
			"email" => email
		}.to_json

		headers = { 
  			"Content-Type"  => "application/json",
 			"Authorization" => "Bearer #{ENV['PAYSTACK_SECRET']}",
		}

		response = HTTParty.post(
			'https://api.paystack.co/transaction/initialize',
			:body => body,
			:headers => headers
		)

		JSON.parse(response.body)["data"]["authorization_url"]
	end

end