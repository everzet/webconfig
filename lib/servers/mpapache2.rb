module Mpapache2Server
  def self.config_ok?
    true
  end
  def self.reload
    system("/opt/local/apache2/bin/apachectl restart")
    true
  end
end
