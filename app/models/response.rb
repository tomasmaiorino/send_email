class Response

	def initialize (message = nil, code = 0, result = nil)
		@message = message
		@code = code
		@result = result
	end
end