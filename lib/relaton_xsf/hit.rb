module RelatonXsf
  class Hit < RelatonBib::Hit
    def fetch
      return @doc if @doc

      agent = Mechanize.new
      resp = agent.get hit[:url]
      hash = YAML.safe_load resp.body
      hash["fetched"] = Date.today.to_s
      @doc = BibliographicItem.from_hash hash
    rescue StandardError => e
      raise RelatonBib::RequestError, e.message
    end
  end
end
