module RelatonXsf
  module Bibliography
    extend self

    def search(ref)
      HitCollection.new(ref).search
    end

    def get(code, _year = nil, _opts = {})
      Util.warn "(#{code}) Fetching from Relaton repository ..."
      result = search(code)
      if result.empty?
        Util.warn "(#{code}) Not found."
        return
      end

      bib = result.first.fetch
      Util.warn "(#{code}) Found: `#{bib.docidentifier.first.id}`"
      bib
    end
  end
end
