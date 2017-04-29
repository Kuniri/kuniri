require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'optparse'

RSpec::Core::RakeTask.new('spec')

# If you want to make this the default task
task :default => :spec

namespace :test do |args|

  desc 'Run acceptance tests'
  task :acceptance do
    sh "tests/run_all"
  end

  desc 'Run unit tests'
  task :unit => :spec

  desc 'Run all tests'
  task :all => [:acceptance, :unit]
end

namespace :parser do |args|

  desc 'Creates a new parser for kuniri with parser:create'
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

    if File.directory?("lib/kuniri/language/#{parsername.downcase}") then
      puts "Error: A folder for this parser code already exists at" +
            "lib/kuniri/language/#{parsername.downcase}"
      exit 1
    end

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
    relative = "require_relative '#{parsername.downcase}/#{parsername.downcase}_syntax'"

    if text.include?(relative) then
      puts "Error: the /lib/kuniri/language/language_factory.rb file already has the require for this parser"
      exit 1
    end

    formated_text = relative + "\n" + text

    condition = "pType.downcase!

      if pType == '#{parsername.downcase}'
        return Languages::#{parsername.capitalize}Syntax.new
      end"

    formated_text = formated_text.gsub("pType.downcase!\n", condition)
    File.open(f, "w") { |file| file << formated_text }

    exit 0
  # End task parser:create
  end

  desc 'Removes a parser for kuniri with parser:remove'
  task :remove do
    options = {}
    OptionParser.new(args) do |opts|
      opts.banner = "Usage: rake user:remove [parser_name]"
    end.parse!

    if ARGV.length <= 1 then
      puts 'Must use pass a parser name'
      exit 0
    end
    parsername = ARGV[1]

    input = ''
    STDOUT.puts "This operation will delete all code related to the #{parsername} parser, are you sure(y/n)?"
    input = STDIN.gets.chomp
    exit 0 unless input.downcase == "y" or input.downcase == "yes"

    if !File.directory?("lib/kuniri/language/#{parsername.downcase}") then
      puts "Error: A folder for this parser code does not exists at lib/kuniri/language/#{parsername.downcase}"
      exit 1
    end

    FileUtils.rm_rf("lib/kuniri/language/#{parsername.downcase}")

    f = 'lib/kuniri/language/language_factory.rb'
    text = File.read(f)
    relative = "require_relative '#{parsername.downcase}/#{parsername.downcase}_syntax'\n"

    if not text.include?(relative) then
      puts "Warning: the /lib/kuniri/language/language_factory.rb file could not found the require for this parser"
    end

    formated_text = text.gsub(relative,'')

    condition = "\n      if pType == '#{parsername.downcase}'
        return Languages::#{parsername.capitalize}Syntax.new
      end"

    formated_text = formated_text.gsub(condition, '')
    File.open(f, "w") { |file| file << formated_text }
    exit 0

  # End task parser:remove
  end
end

