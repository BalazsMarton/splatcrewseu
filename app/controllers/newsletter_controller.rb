class NewsletterController < ApplicationController
	require 'rest-client'

	def new
    	@newsletter = Newsletter.new
  	end

  	def create
  		@newsletter = Newsletter.new(newsletter_params)
  		
  		respond_to do |format|


	  		format.js do 
	  			if @newsletter.valid?

	  				api_key = ENV['SENDGRID_API_KEY']
					headers = {'Authorization' => "Bearer #{api_key}"}
					mail = @newsletter.email
					data = {:email => mail }

					reset = RestClient.delete "https://api.sendgrid.com/v3/asm/groups/3365/suppressions/#{mail}", headers
					response = RestClient.post 'https://api.sendgrid.com/v3/contactdb/recipients', [data].to_json, headers
					
					flash.now[:notice] = "köszönjük hogy feliratkozott az alábbi címmel: #{mail}"
	  			else
          			flash.now[:error]
	  			end
	  		end

  		end

  	end

  	private

  	def newsletter_params
    params.require(:newsletter).permit( :email)
  	end

end