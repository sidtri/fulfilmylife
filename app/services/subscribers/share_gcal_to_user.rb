# Share google service calendar to user
class ShareGcalToUser
	include Wisper::Publisher
	
	# param [String] email
	def call(email)
		begin
			Rails.configuration.gcal_service.get_acl('primary', "user:#{email}")
		rescue
			Rails.configuration.gcal_service.insert_acl(
				'primary',
				Google::Apis::CalendarV3::AclRule.new(
					role: 'reader', 
					scope: Google::Apis::CalendarV3::AclRule::Scope.new(
						value: "#{email}",
						type: 'user',
						id: "user:#{email}",
						kind: "calendar#aclRule"
					)
				)
			)
		end
	end
end