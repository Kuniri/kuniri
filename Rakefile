require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'optparse'

RSpec::Core::RakeTask.new('spec')

# If you want to make this the default task
task :default => :spec

namespace :parser do |args|
  desc 'Creates a new parser for kuniri with parser:new'
  # environment is required to have access to Rails models
  task :create do
    options = {}
    OptionParser.new(args) do |opts|
      opts.banner = "Usage: rake user:create [parser_name]"
    end.parse!

    if ARGV.length <= 1 then
      puts 'Must use pass a parser name'
      exit 0
    end
    parsername = ARGV[1]

    FileUtils.mkdir_p("lib/kuniri/language/#{parsername.downcase}")
    Dir.glob( 'data/*.rb' ).select { |f| File.file?( f ) }.each do |f|
      fdest = File.basename(f).gsub('lang', parsername.downcase)
      dest = "lib/kuniri/language/#{parsername.downcase}/#{fdest}"
      FileUtils.cp( f, dest )
      p dest
    end

    Dir.glob( "lib/kuniri/language/#{parsername.downcase}/*.rb" ).select { |f| File.file?( f ) }.each do |f|
      text = File.read(f)
      formated_text = text.gsub('{LANG}', parsername.capitalize)
      formated_text = formated_text.gsub('{lang}', parsername.downcase)
      File.open(f, "w") { |file| file << formated_text }
    end

    f = 'lib/kuniri/language/language_factory.rb'
    text = File.read(f)
    formated_text = "require_relative '#{parsername.downcase}/#{parsername.downcase}_syntax'\n" + text

    condition = "pType.downcase!

      if pType == '#{parsername.downcase}'
        return Languages::#{parsername.capitalize}Syntax.new
      end"

    formated_text = formated_text.gsub("pType.downcase!\n", condition)
    File.open(f, "w") { |file| file << formated_text }

    exit 0
  end
end

