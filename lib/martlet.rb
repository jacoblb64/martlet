require 'martlet/client'
require 'martlet/authenticator'
require 'martlet/day_conversions'
require 'martlet/transcript'
require 'martlet/transcript_parser'
require 'martlet/schedule'
require 'martlet/schedule_parser'
require 'martlet/record'
require 'martlet/grade'
require 'martlet/course'
require 'martlet/version'

module Martlet
  def self.new(*args)
    Client.new(*args)
  end
end
