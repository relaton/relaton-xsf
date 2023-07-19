describe RelatonXsf::XMLParser do
  it "returns RelatonXsf::BibliographicItem" do
    xml = File.read "spec/fixtures/bibdata.xml", encoding: "UTF-8"
    item = RelatonXsf::XMLParser.from_xml xml
    expect(item).to be_instance_of RelatonXsf::BibliographicItem
    expect(item.docidentifier.first.id).to eq "XEP 0001"
  end
end
