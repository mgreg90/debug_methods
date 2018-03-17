module DebugMethods
  class Configuration
    attr_accessor :environments
    
    DEFAULT_ENVIRONMENTS = [:debug, :development, :localhost]
    
    def initialize
      @environments = DEFAULT_ENVIRONMENTS
    end
    
  end
end