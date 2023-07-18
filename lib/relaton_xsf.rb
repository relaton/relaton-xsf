# frozen_string_literal: true

require "mechanize"
require "relaton/index"
require "relaton_bib"
require_relative "relaton_xsf/version"
require_relative "relaton_xsf/bibliographic_item"
require_relative "relaton_xsf/xsf_bibliography"
require_relative "relaton_xsf/bibxml_parser"
require_relative "relaton_xsf/data_fetcher"

module RelatonXsf
  class Error < StandardError; end
  # Your code goes here...
end
