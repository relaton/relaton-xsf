module RelatonXsf
  module Bibliography
    extend self

    def search(ref)
      HitCollection.new(ref).search
    end

    def get(code, _year = nil, _opts = {})
      warn "[relaton-xsf] (#{code}) fetching..."
      result = search(code)
      if result.empty?
        warn "[relaton-xsf] (#{code}) nothing found"
        return
      end

      bib = result.first.fetch
      warn "[relaton-xsf] (#{code}) found #{bib.docidentifier.first.id}"
      bib
    end
  end
end
