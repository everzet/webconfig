#!/usr/bin/env ruby

require 'yaml'

class HostEditor
  def initialize
    @domains = YAML.load_file(APP_ROOT + '/config/config.yml')
  end

  def addHost(host, template, location)
    @domains[host] = {
      'template' => template,
      'location' => location
    }
  end

  def getHost(host)
    puts @domains[host].to_yaml
  end

  def getAll
    puts @domains.to_yaml
  end

  def remHost(host)
    @domains.delete host
  end

  def save
    File.open(APP_ROOT + '/config/config.yml', 'w') do |out|
      YAML.dump(@domains, out )
    end
  end
end

he = HostEditor.new

case ARGV[0]
when 'add'
  he.addHost ARGV[1], ARGV[2], ARGV[3]
when 'rm'
  he.remHost ARGV[1]
when '?'
  puts '[add/rm/reload] host template location'
when 'reload'
  system(APP_ROOT + '/bin/webconfig');
else
  if ARGV[0]
    he.getHost ARGV[0]
  else
    he.getAll
  end
end

he.save
