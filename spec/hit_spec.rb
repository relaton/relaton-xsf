describe RelatonXsf::Hit do
  subject { RelatonXsf::Hit.new url: "https://example.com" }

  it "raises RelatonBib::RequestError" do
    agent = double "agent"
    expect(agent).to receive(:get).and_raise SocketError
    expect(Mechanize).to receive(:new).and_return agent
    expect { subject.fetch }.to raise_error RelatonBib::RequestError
  end
end
