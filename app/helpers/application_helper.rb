module ApplicationHelper

	# Returns full title for Pages
	def full_title(title = "")
		@base_title = "BookWorm: A Portal for BookWorms"
		title.empty? ? @base_title : "#{title} | #{@base_title}"
	end
end
