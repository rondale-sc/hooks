#!/usr/bin/env ruby

["flog"].each do |gem|
  begin
    require gem
  rescue LoadError
    $stdout.puts "#{gem} is not loaded."
    exit 1
  end
end

class FlogPreCommit
  attr_reader :staged_files, :colors, :flog

  def initialize(opts={})
    @colors       = {:red => 31, :green => 32, :yellow => 33}
    @staged_files = opts.fetch(:files, false) || get_staged_files_from_git
    @flog         = opts.fetch(:flog, false) || Flog.new(:continue => true, :quiet => true)
  end

  def to_s
    output = generate_output.join("\n")
    $stdout.puts output
    output
  end

  private

  def generate_output
    staged_files.collect do |file|
      next unless file =~ /\.rb\z/
      flog.flog(file)
      "Flog: Avg ( #{ average(flog) } ), Total ( #{ flog.total } ) - #{file}."
    end
  end

  def get_staged_files_from_git
    `git diff --cached --name-only`.split
  end

  def colorize(str,color)
    "\e[#{colors[color]}m#{str}\e[0m"
  end

  def colorized_average(avg)
    case avg
    when 0..20
      colorize(avg, :green)
    when 21..60
      colorize(avg, :yellow)
    else
      colorize(avg, :red)
    end
  end

  def average(flog)
   colorized_average flog.average
  end
end

if __FILE__ == $0
 FlogPreCommit.new.to_s
end
