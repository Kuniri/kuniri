require_relative 'preparser.rb'

class RubyPreParser < PreParser
  def initialize
    @on_multiline_comment = false
  end

  def remove_comments(line)
    @on_multiline_comment = true if line =~ /^=begin(.*?)/
    if @on_multiline_comment
      pre_parsed_line = ''
    else
      comment_regex = /(?<non_comm>[^#]*)#.*/
      match = line.match(comment_regex)
      pre_parsed_line = match.nil? ? line : match['non_comm']
    end
    @on_multiline_comment = false if line =~ /^=end/
    return pre_parsed_line
  end

  def zip_multiple_lines_command(line) end

  def split_multiple_command_line(line) end
end
