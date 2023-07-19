module RelatonXsf
  class XMLParser < RelatonBib::XMLParser
    #
    # Create bibliographic item
    #
    # @param item_hash [Hash] bibliographic item hash
    #
    # @return [RelatonXsf::BibliographicItem] bibliographic item
    #
    def self.bib_item(item_hash)
      BibliographicItem.new(**item_hash)
    end
  end
end
