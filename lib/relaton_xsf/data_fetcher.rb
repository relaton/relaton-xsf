module RelatonXsf
  class DataFetcher
    # @param output [String]
    # @param format [String]
    def initialize(output, format)
      @output = output
      @format = format
      @ext = format.sub(/^bib/, "")
      @files = []
    end

    def self.fetch(output: "data", format: "yaml")
      warn "fetching data to #{output} in #{format} format"
      t1 = Time.now
      warn "start at #{t1}"
      FileUtils.mkdir_p output
      new(output, format).fetch
      t2 = Time.now
      t = t2 - t1
      warn "finished at #{t2} (#{t.round} seconds)"
    end

    def index
      @index ||= Relaton::Index.find_or_create :xsf, file: "index-v1.yaml"
    end

    def fetch
      agent = Mechanize.new
      resp = agent.get "https://xmpp.org/extensions/refs/"
      resp.xpath("//a[contains(@href, 'XEP-')]").each do |link|
        doc = agent.get link[:href]
        bib = BibXMLParser.parse doc.body
        write_doc bib
      end
      index.save
    end

    def write_doc(bib)
      id = bib.docidentifier.find(&:primary).id
      file = File.join @output, "#{id.gsub(' ', '-').downcase}.#{@ext}"
      if @files.include? file
        Util.warn "#{file} already exists"
      end
      File.write file, serialize(bib), encoding: "UTF-8"
      @files << file
      index.add_or_update id, file
    end

    def serialize(bib)
      case @format
      when "yaml" then bib.to_hash.to_yaml
      when "xml" then bib.to_xml bibdata: true
      else bib.send "to_#{@format}"
      end
    end
  end
end
