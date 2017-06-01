require 'set'
require_relative 'preparser.rb'

ENDS_WITH_END = Set.new [
  'do',
  'if',
  'unless',
  'for'
]


class RubyPreParser < PreParser

  def initialize
    @LINE_CONTINUATION_CHARS = ['.', ',', '(']
    @on_multiline_comment = false
  end

  def pre_parse_multiple_lines(lines)
    text = lines.join()
    words = text.split
    text = convert_do_blocks_into_brackets(words)
    return text.split('\n')
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

  def zip_multiple_lines_command(lines)
    zipped_lines = []
    curr_line = ''
    append_next = true
    lines.each do |line|
      if append_next
        curr_line << line
      else
        zipped_lines.push(curr_line)
        curr_line = line
      end
      append_next = @LINE_CONTINUATION_CHARS.include?(line[-1])
    end
    zipped_lines.push(curr_line)
    return zipped_lines
  end

  def split_multiple_command_lines(lines)
    return lines
  end

  def do_blocks_into_brackets(words)
    blocks_into_brackets_recur(words, 0)
    return words.join(' ')
  end

  def blocks_into_brackets_recur(words, head)
    loop_depth = 0
    idx = 0
    while (idx < words.length) do
       wd = words[idx]
       if wd == 'do'
         words[idx] = "{"
         idx = blocks_into_brackets_recur(words, idx+1)
       elsif ENDS_WITH_END.include? wd
         loop_depth += 1
         idx += 1
       elsif wd == 'end'
         loop_depth -= 1
         if loop_depth == -1
           words[idx] = "}"
           return idx+1
         end
         idx += 1
       else
         idx += 1
       end
    end
  end
end

