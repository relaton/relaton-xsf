describe RelatonXsf::BibXMLParser do
  it "returns bibliographic item" do
    args = { docnumber: "XEP-0001", docstatus: "draft", doctype: "standard" }
    expect(RelatonXsf::BibliographicItem).to receive(:new).with(args).and_return :bibitem
    expect(described_class.bib_item(args)).to eq :bibitem
  end
end
