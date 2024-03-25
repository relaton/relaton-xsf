module RelatonXsf
  module Bibliography
    extend self

    def search(ref)
      HitCollection.new(ref).search
    end

    def get(code, _year = nil, _opts = {})
      Util.info "Fetching from Relaton repository ...", key: code
      result = search(code)
      if result.empty?
        Util.info "Not found.", key: code
        return
      end

      bib = result.first.fetch
      Util.info "Found: `#{bib.docidentifier.first.id}`", key: code
      bib
    end
  end
end
