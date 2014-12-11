
class Controller
  def self.insert(year, month, day, comment)
    mdir = getMonthDir year, month
    makeDir mdir
    f = File.open("#{mdir}/#{day}.data", "a")
    f.puts comment
    f.close
  end

  def self.hasSchedule(year, month, day)
    has = true
    file = "%s/%s.data" % [getMonthDir(year, month), day]
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


