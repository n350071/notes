describe ZeroichiHacker do
  describe '#work' do
  subject { hacker.work }
  let(:hacker) { ZeroichiHacker.new }

  it "returns maintenable solution" do
      is_expected.to eq({
        cycle:       "1week",
        approach:    "minimal steps",
        cost:        "minimum",
        quality:     [
                        "modifiability",
                        "tesability",
                        "analyzability"
                      ],
        future_cost: "minimum",
      })
    end
  end
end













