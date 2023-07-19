module RelatonXsf
  class HitCollection < RelatonBib::HitCollection
    INDEX_FILE = "index-v1.yaml".freeze
    GHDATA_URL = "https://raw.githubusercontent.com/relaton/relaton-data-xsf/main/".freeze

    def search
      @array = index.search(text).sort_by { |hit| hit[:id] }.map do |row|
        Hit.new url: "#{GHDATA_URL}#{row[:file]}"
      end
      self
    rescue StandardError => e
      raise RelatonBib::RequestError, e.message
    end

    def index
      @index ||= Relaton::Index.find_or_create :xsf, url: "#{GHDATA_URL}index-v1.zip", file: INDEX_FILE
    end
  end
end
