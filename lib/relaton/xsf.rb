# frozen_string_literal: true

require "mechanize"
require "relaton/index"
require "relaton/bib"
require_relative "xsf/version"
require_relative "xsf/util"
require_relative "xsf/item"
require_relative "xsf/bibitem"
require_relative "xsf/bibdata"
# require_relative "relaton_xsf/bibliography"
# require_relative "relaton_xsf/hit_collection"
# require_relative "relaton_xsf/hit"
# require_relative "relaton_xsf/xml_parser"
# require_relative "relaton_xsf/bibxml_parser"
# require_relative "relaton_xsf/hash_converter"
# require_relative "relaton_xsf/data_fetcher"

module Relaton
  module Xsf
    class Error < StandardError; end
    # Your code goes here...
    def self.grammar_hash
      # gem_path = File.expand_path "..", __dir__
      # grammars_path = File.join gem_path, "grammars", "*"
      # grammars = Dir[grammars_path].sort.map { |gp| File.read gp }.join
      Digest::MD5.hexdigest Relaton::Bib::VERSION # grammars
    end
  end
end
