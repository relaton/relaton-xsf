module RelatonXsf
  module Util
    extend RelatonBib::Util

    def self.logger
      RelatonXsf.configuration.logger
    end
  end
end
