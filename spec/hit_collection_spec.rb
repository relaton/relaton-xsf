describe RelatonXsf::HitCollection do
  subject(:collection) { RelatonXsf::HitCollection.new "XEP 0001" }

  it "raise RelatonBib::RequestError" do
    expect(subject).to receive(:index).and_raise Timeout::Error, "timeout"
    expect { subject.search }.to raise_error RelatonBib::RequestError, "timeout"
  end
end
