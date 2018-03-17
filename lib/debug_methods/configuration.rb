module DebugMethods
  class Configuration
    attr_accessor :environments

    DEFAULT_ENVIRONMENTS = [:development]

    def initialize
      @environments = DEFAULT_ENVIRONMENTS
    end

  end
end