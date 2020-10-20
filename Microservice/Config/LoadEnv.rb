require 'yaml'

file_load = YAML.load_file("Config/application.yml")
file_load["development"].each do |key, value|
  ENV[key.to_s] = value.to_s
end
