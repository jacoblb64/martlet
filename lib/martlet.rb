require 'martlet/client'
require 'martlet/authenticator'
require 'martlet/version'

module Martlet
  def self.new(*args)
    Client.new(*args)
  end
end
