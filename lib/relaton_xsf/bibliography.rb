module RelatonXsf
  module Bibliography
    extend self

    def search(ref)
      HitCollection.new(ref).search
    end

    def get(code, _year = nil, _opts = {})
      Util.warn "(#{code}) fetching..."
      result = search(code)
      if result.empty?
        Util.warn "(#{code}) nothing found"
        return
      end

      bib = result.first.fetch
      Util.warn "(#{code}) found `#{bib.docidentifier.first.id}`"
      bib
    end
  end
end
