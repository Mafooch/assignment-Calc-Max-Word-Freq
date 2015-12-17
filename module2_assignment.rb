class LineAnalyzer
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize content, line_number
    @content = content
    @line_number = line_number
    calculate_word_frequency content
  end

  def calculate_word_frequency content
    word_usage = Hash.new
    word_array = content.downcase.split
    word_array.each do |word|
      word_usage[word] ? word_usage[word] += 1 : word_usage[word] = 1
    end

    @highest_wf_count = word_usage.values.max
    @highest_wf_words = Array.new

    word_usage.select do |word, frequency|
      @highest_wf_words << word if frequency == @highest_wf_count
    end
  end
end

class Solution
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines
  def initialize
    @analyzers = Array.new
  end

  def analyze_file
    line_number = 0
    File.foreach("test.txt") do |line|
      line_number += 1
      @analyzers << LineAnalyzer.new(line.chomp, line_number)
    end
  end

  def calculate_line_with_highest_frequency
    max_wf_counts = Array.new
    @analyzers.each do |analyzer|
      max_wf_counts << analyzer.highest_wf_count
    end

    @highest_count_across_lines = max_wf_counts.max
    @highest_count_words_across_lines = Array.new

    @analyzers.each do |analyzer|
      highest_count_words_across_lines << analyzer if analyzer.highest_wf_count == @highest_count_across_lines
    end
  end

  def print_highest_word_frequency_across_lines
    @highest_count_words_across_lines.each do |analyzer|
      puts "#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number})"
    end
  end
end


s = Solution.new
s.analyze_file
s.calculate_line_with_highest_frequency
s.print_highest_word_frequency_across_lines
