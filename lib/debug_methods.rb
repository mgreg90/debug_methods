require "debug_methods/configuration"
require "debug_methods/version"

module DebugMethods

  def self.included(base)
    base.extend ClassMethods
  end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.allowed_environment?
    defined?(Rails) && DebugMethods.configuration.environments.any? do |env|
      Rails.env.send(:"#{env}?")
    end
  end

  module ClassMethods
    def debug_methods
      yield if DebugMethods.allowed_environment?
    end
  end

end
