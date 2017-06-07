require_relative 'preparser.rb'

class RubyPreParser < PreParser

  def initialize
    @LINE_CONTINUATION_CHARS = ['.', ',', '(']
    @INVALID_INDEX = -2
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

  def get_oneline_comment(line)
    comment_regex = /^#(?<comment>.*)$/
    ;match = line.match(comment_regex)
    match.nil? ? nil : match["comment"]
  end

  def zip_multiple_lines_comment(lines, head, tail)
    begin_length = "=begin ".length
    comment = lines[head][:code][begin_length .. -1]
    comment = (comment.nil?)? "": comment

    (head+1).upto(tail-1) do |index|
      comment += lines[index][:code] + " "
    end
    return comment
  end

  def get_multiple_lines_comment(lines)
    head = tail = @INVALID_INDEX
    lines.each_with_index do |line, index|
      if not line[:code].nil?
        first_word = line[:code].split[0]
        if first_word == "=begin"
          head = index
        elsif first_word == "=end"
          tail = index
          lines[head][:comment] = zip_multiple_lines_comment(lines, head, tail)
          lines[head][:code] = nil
          (head+1).upto(tail) do
            lines.delete_at(head+1)
          end
          head = tail = @INVALID_INDEX
        end
      end
    end
  end



  def split_multiple_command_lines(lines)
    return lines
  end
end
