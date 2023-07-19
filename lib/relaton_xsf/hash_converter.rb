module RelatonXsf
  class HashConverter < RelatonBib::HashConverter
    class << self
      # @param item_hash [Hash]
      # @return [RelatonBib::BibliographicItem]
      def bib_item(item_hash)
        BibliographicItem.new(**item_hash)
      end
    end
  end
end
