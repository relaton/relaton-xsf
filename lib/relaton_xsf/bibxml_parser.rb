module RelatonXsf
  module BibXMLParser
    include RelatonBib::BibXMLParser
    extend self

    # @param item_hash [Hash]
    # @return [RelatonXsf::BibliographicItem]
    def bib_item(item_hash)
      BibliographicItem.new(**item_hash)
    end
  end
end
