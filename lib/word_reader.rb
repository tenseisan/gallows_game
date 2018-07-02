# Read words from file
class WordReader
  def read_from_args
    ARGV[0]
  end

  def read_from_file(file_name)
    return unless File.exist?(file_name)

    begin
      lines = File.readlines(file_name)
    rescue SystemCallError
      abort 'Файл со словами не найден!'
    end
    lines.sample.chomp
  end
end
