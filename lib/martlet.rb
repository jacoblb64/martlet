require 'martlet/client'
require 'martlet/authenticator'
require 'martlet/transcript'
require 'martlet/transcript_parser'
require 'martlet/record'
require 'martlet/version'

module Martlet
  def self.new(*args)
    Client.new(*args)
  end
end
