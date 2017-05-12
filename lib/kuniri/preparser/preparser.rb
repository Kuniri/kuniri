class PreParser
  def pre_parse(source, out_path)
    pre_parsed_lines = []
    for line in source
      pre_parsed_line = remove_comments(line)
      pre_parsed_line.slice!("\n")
      pre_parsed_lines.push(pre_parsed_line) unless (pre_parsed_line.empty?)
    end
    out_file = File.open(out_path, "w")
    for pre_parsed_line in pre_parsed_lines
      out_file.write(pre_parsed_lines)      
    end
  end

  def remove_comments(line)
    raise NotImplementedError
  end
end
