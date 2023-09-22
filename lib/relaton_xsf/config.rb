module RelatonXsf
  module Config
    include RelatonBib::Config
  end
  extend Config

  class Configuration < RelatonBib::Configuration
    PROGNAME = "relaton-xsf".freeze
  end
end
