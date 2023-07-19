require "relaton/processor"

module RelatonXsf
  class Processor < Relaton::Processor
    attr_reader :idtype

    def initialize # rubocop:disable Lint/MissingSuper
      @short = :relaton_xsf
      @prefix = "XEP"
      @defaultprefix = %r{^XEP\s}
      @idtype = "XEP"
      @datasets = %w[xep-xmpp]
    end

    # @param code [String]
    # @param date [String, nil] year
    # @param opts [Hash]
    # @return [RelatonXsf::BibliographicItem]
    def get(code, date, opts)
      ::RelatonXsf::Bibliography.get(code, date, opts)
    end

    #
    # Fetch all the documents from http://xml2rfc.tools.ietf.org/public/rfc/bibxml-3gpp-new/
    #
    # @param [String] source source name
    # @param [Hash] opts
    # @option opts [String] :output directory to output documents
    # @option opts [String] :format
    #
    def fetch_data(_source, opts)
      ::RelatonXsf::DataFetcher.fetch(**opts)
    end

    # @param xml [String]
    # @return [RelatonXsf::BibliographicItem]
    def from_xml(xml)
      ::RelatonXsf::XMLParser.from_xml xml
    end

    # @param hash [Hash]
    # @return [RelatonXsf::BibliographicItem]
    def hash_to_bib(hash)
      item_hash = ::RelatonXsf::HashConverter.hash_to_bib(hash)
      ::RelatonXsf::BibliographicItem.new(**item_hash)
    end

    # Returns hash of XML grammar
    # @return [String]
    def grammar_hash
      @grammar_hash ||= ::RelatonBib.grammar_hash
    end

    #
    # Remove index file
    #
    def remove_index_file
      Relaton::Index.find_or_create(:xsf, url: true, file: HitCollection::INDEX_FILE).remove_file
    end
  end
end
