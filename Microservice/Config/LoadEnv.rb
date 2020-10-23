require 'yaml'

file_load = YAML.load_file("Config/application.yml")
file_load["development"].each do |key, value|
  ENV[key.to_s] = value.to_s
end

TRANSLATE = {}

Dir['Locals/*.yml'].each do |file_name|
  next if File.directory? file_name
  TRANSLATE.merge!(YAML.load_file(file_name))
end
