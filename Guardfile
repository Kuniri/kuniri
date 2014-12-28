# Guardfile
guard 'rspec', cmd: "bundle exec rspec", :all_after_pass => false, 
  :failed_mode => :none do
  watch(%r{\Aspec/.+_spec\.rb\z})
  watch(%r{\Aapp/(.+)\.rb\z})   { |m| "spec/app/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

