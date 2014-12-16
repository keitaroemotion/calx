
class Controller
  def self.getext(isholiday)
    if isholiday
      return "holiday"
    end
    return "data"
  end

  def self.delete(year, month, day)
    mdir = getMonthDir year, month
    dataf = "#{mdir}/#{day}.data"
    holif = "#{mdir}/#{day}.holiday"
    require 'FileUtils'
    if File.exist? dataf
      FileUtils.rm dataf
    elsif File.exist? holif
      FileUtils.rm holif
    end
  end


  def self.edit(year, month, day, comment, isholiday=false)
    mdir = getMonthDir year, month
    makeDir mdir
    targetfile = "#{mdir}/#{day}.#{getext(isholiday)}"
    #command
  end

  def self.insert(year, month, day, comment, isholiday=false)
    mdir = getMonthDir year, month
    makeDir mdir
    f = File.open("#{mdir}/#{day}.#{getext(isholiday)}", "a")
    f.puts comment
    f.close
  end

  def self.get_text(year, month, day, isholiday=false)
    mdir = getMonthDir year, month
    makeDir mdir
    targetfile = "#{mdir}/#{day}.#{getext(isholiday)}"
    if !File.exist? targetfile
      return Array.new
    end

    f = File.open(targetfile, "r")
    contents = f.to_a
    f.close
    contents
  end


  def self.hasSchedule(year, month, day, isholiday=false)
    has = true
    file = "%s/%s.%s" % [getMonthDir(year, month), day, getext(isholiday)]
    if (!File.exist?(file))
      has = false
    end
    has
  end

  $resource_dir_root = "/usr/local/etc/calx"
  $resource_dir_target = "#{$resource_dir_root}/caldata"

  def self.getMonthDir(year, month)
    "%s/%s/%s" % [$resource_dir_target, year, month]
  end

  def self.makeDir(dir)
    require 'fileutils'
    FileUtils.mkdir_p dir
  end
end


