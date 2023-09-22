describe RelatonXsf::HashConverter do
  it "returns RelatonXsf::BibliographicItem" do
    docid = RelatonBib::DocumentIdentifier.new(id: "XEP 0001", type: "XSF")
    bib = RelatonXsf::HashConverter.bib_item docid: [docid]
    expect(bib).to be_instance_of RelatonXsf::BibliographicItem
    expect(bib.docidentifier.first).to be_instance_of RelatonBib::DocumentIdentifier
    expect(bib.docidentifier.first.id).to eq "XEP 0001"
  end
end
