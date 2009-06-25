module LocalhostServer
  def self.config_ok?
    true
  end

  def self.reload
    File.open('/etc/hosts.tmp', "w") do |file|
      File.foreach("/etc/hosts") do |line|
        break if line.match("\# CUSTOM HOSTS")
        file.puts line
      end
      file.puts "\# CUSTOM HOSTS"
      File.foreach(Webconfig::WEBCONFIG_PATH + '/gen/localhost.gen.conf') do |line|
        file.puts line unless line.match(/^$/)
      end
    end
    FileUtils.cp '/etc/hosts', '/etc/hosts.back'
    FileUtils.mv '/etc/hosts.tmp', '/etc/hosts'
  end
end
