require_relative 'preparser.rb'

class RubyPreParser < PreParser
  def initialize
    @on_multiline_comment = false
  end
  def remove_comments(line)
    if line =~ /^=begin(.*?)/
      @on_multiline_comment = true
    end
    if @on_multiline_comment
      pre_parsed_line = ''
    else
      comment_regex = /(?<non_comm>[^#]*)#.*/
      match = line.match(comment_regex)
      pre_parsed_line = if not match.nil? then match["non_comm"] else line end
    end
    if line =~ /^=end/
      @on_multiline_comment = false
    end
    return pre_parsed_line
  end
end
