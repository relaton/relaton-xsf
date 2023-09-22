describe RelatonXsf::DataFetcher do
  it "initilizes" do
    df = described_class.new "data", "bibxml"
    expect(df.instance_variable_get(:@output)).to eq "data"
    expect(df.instance_variable_get(:@format)).to eq "bibxml"
    expect(df.instance_variable_get(:@ext)).to eq "xml"
    expect(df.instance_variable_get(:@files)).to eq []
  end

  it "fetches data" do
    df = double "data fetcher"
    expect(df).to receive(:fetch)
    expect(described_class).to receive(:new).with("data", "yaml").and_return df
    described_class.fetch
  end

  context "instance methods" do
    subject { described_class.new "data", "yaml" }

    it "index" do
      expect(subject.index).to be_instance_of Relaton::Index::Type
    end

    it "#fetch" do
      agent = double "agent"
      resp = Nokogiri::XML <<~XML
        <html>
          <body>
            <pre>
              <a href="reference.XSF.XEP-0001.xml">reference.XSF.XEP-0001.xml</a>
            </pre>
          </body>
        </html>
      XML
      expect(agent).to receive(:get).with("https://xmpp.org/extensions/refs/").and_return resp
      expect(Mechanize).to receive(:new).and_return agent
      doc = double "doc", body: :body
      expect(agent).to receive(:get).with("reference.XSF.XEP-0001.xml").and_return doc
      expect(RelatonXsf::BibXMLParser).to receive(:parse).with(:body).and_return :bib
      expect(subject).to receive(:write_doc).with(:bib)
      expect(subject.index).to receive(:save)
      subject.fetch
    end

    context "#write_doc" do
      let(:bib) { double "bibliographic item", docidentifier: [double(id: "XEP-0001", primary: true)] }

      before do
        expect(subject).to receive(:serialize).with(bib).and_return :yaml
        expect(File).to receive(:write).with("data/xep-0001.yaml", :yaml, encoding: "UTF-8")
        expect(subject.index).to receive(:add_or_update).with("XEP-0001", "data/xep-0001.yaml")
      end

      it "no duplications" do
        subject.write_doc bib
        expect(subject.instance_variable_get(:@files)).to eq ["data/xep-0001.yaml"]
      end

      it "duplications" do
        subject.instance_variable_set :@files, ["data/xep-0001.yaml"]
        expect { subject.write_doc bib }.to output(
          "WARNING: data/xep-0001.yaml already exists\n",
        ).to_stderr
      end
    end

    context "#serialize" do
      let(:bib) { double "bibliographic item" }

      it "yaml" do
        hash = double "hash"
        expect(bib).to receive(:to_hash).and_return hash
        expect(hash).to receive(:to_yaml).and_return :yaml
        expect(subject.serialize(bib)).to eq :yaml
      end

      it "xml" do
        subject.instance_variable_set :@format, "xml"
        expect(bib).to receive(:to_xml).with(bibdata: true).and_return :xml
        expect(subject.serialize(bib)).to eq :xml
      end

      it "bibxml" do
        subject.instance_variable_set :@format, "bibxml"
        expect(bib).to receive(:to_bibxml).and_return :bibxml
        expect(subject.serialize(bib)).to eq :bibxml
      end
    end
  end
end
