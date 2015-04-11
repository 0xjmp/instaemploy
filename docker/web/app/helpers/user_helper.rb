module UserHelper

	def user_github_authed?
		current_user.provider == 'github' && senior_signed_in? || junior_signed_in?
	end
	
end