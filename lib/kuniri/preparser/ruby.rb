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
    match = line.match(comment_regex)
    match.nil? ? nil : match['comment']
  end

  def zip_multiple_lines_comment(lines, head, tail)
    begin_comment_token = '=begin '
    begin_length = begin_comment_token.length

    comment = lines[head][:code][begin_length..-1]
    comment = comment.nil? ? '' : comment + ' '

    (head + 1).upto(tail - 1) { |index| comment += lines[index][:code] + ' ' }

    return comment
  end

  def get_multiple_lines_comment(lines)
    head = @INVALID_INDEX

    i = -1
    while (i < lines.length - 1)
      i += 1

      next if lines[i][:code].nil?

      first_word = lines[i][:code].split[0]
      head = i if first_word == '=begin'
      next if first_word != '=end'

      tail = i
      lines[head][:comment] = zip_multiple_lines_comment(lines, head, tail)
      i = head + 1
      lines[head][:code] = nil

      (head + 1).upto(tail) { lines.delete_at(head + 1) }

      head = tail = @INVALID_INDEX
    end

    lines
  end

  def split_multiple_command_lines(lines)
    return lines
  end
end
