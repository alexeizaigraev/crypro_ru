
require 'fileutils'

class Crypto

  def initialize fname
    @txt = '' #   логи и сообщения

    @mail1 = 'neya1969@gmail.com'
    @mail2 = 'vovan@gmail.com'

    @in_fname = fname # имя файлв в папке in
    @short_fname = fname.split('/')[-1] # короткое имя файла
    @arhiv_fname = "arhiv/#{@short_fname}" # имя файла в архиве

    @prefixes = ['f', 'qu-qu'] # шифруемые файлы должны начинаться с префиксов

    @comand = mk_gpg_command # клманда шифрования

    @flag_to_arhiv = mk_flag_to_arhiv
  end

  def mk_flag_to_arhiv
    @prefixes.each do |prefix|
      return false if 0 == @short_fname.index(prefix)
    end
    true
  end

  def mk_gpg_command
    "gpg --output out/#{@short_fname}.gpg --encrypt --recipient #{@mail1} --recipient #{@mail2} in/#{@short_fname}"
  end

  def log_it
    File.open('logi.txt', 'a') do |file|
      file.puts "#{@txt} #{Time.now}"
    end
    puts @txt
  end

  def main
    if @flag_to_arhiv
      @txt = "to_arhiv #{@short_fname}"
      log_it
      comand = "mv #{@in_fname} #{@arhiv_fname}"
      begin
        system(comand)
      rescue
        z = nil
      end
    else
      system(@comand)
      puts 'y'
      puts "\n"
      @txt = @comand
      log_it
      File.delete(@in_fname)
    end
  end


end

fnames = Dir.glob("in/*")
fnames.each do |fname|
  my_file = Crypto.new(fname)
  my_file.main
end
