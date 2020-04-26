#!/usr/bin/env ruby

def run(command, print: false)
	puts "Running: #{command}" if print
	`command`
end

begin
	`brew install lastpass-cli`

	puts 'Enter your lastpass login: '
	login = gets.chomp

	`lpass login #{login}`

	# The `mac_install_options` lastpass record has the following format:
	#
	# lastpass_record_name:local_directory:local_filename
	#
	# local_filename (and the colon preceding it) can be left out and the 
	# lastpass_record_name will be used for it.
	#
	# blank lines are skipped, comments are allowed with first character '#'

	options = `lpass show --notes mac_install_options`

	options.split("\n").each do |option|
		next if option[0] == "#" || option.strip == ""

		lastpass_name, local_dir, local_filename = option.split(":")

		local_dir = File.expand_path(local_dir)
		local_path = File.join(local_dir, local_filename || lastpass_name)
		
		run(%Q(chmod 777 #{local_path})) if File.exists?(local_path)

		run(%Q(mkdir -p "#{local_dir}"))
		run(%Q(lpass show --notes "#{lastpass_name}" > "#{local_path}"), print: true)
		run(%Q(chmod 400 "#{local_path}"))
	end
ensure
	`lpass logout --force`
end
