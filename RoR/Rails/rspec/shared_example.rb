describe 'how_are_you?' do
  shared_examples_for "happy" do
    it{expect(dog.feel_good?).to be true}
  end

  context 'good status' do
    it_should_behave_like("happy"){let(:dog){FactoryGirl.create :dog, status: :eating}}
    it_should_behave_like("happy"){let(:dog){FactoryGirl.create :dog, status: :excited}}
    it_should_behave_like("happy"){let(:dog){FactoryGirl.create :dog, status: :running}}
  end
end



shared_examples_for "0-23 hour" do |expectation|
  it{expect(hour.save).to be expectation}
end
describe 'hours' do
  it_should_behave_like("0-23 hour", false){let(:hour){FactoryGirl.create :hour, hour: -1}}
  it_should_behave_like("0-23 hour", true) {let(:hour){FactoryGirl.create :hour, hour: 0}}
  it_should_behave_like("0-23 hour", true) {let(:hour){FactoryGirl.create :hour, hour: 1}}
  it_should_behave_like("0-23 hour", true) {let(:hour){FactoryGirl.create :hour, hour: 22}}
  it_should_behave_like("0-23 hour", true) {let(:hour){FactoryGirl.create :hour, hour: 23}}
  it_should_behave_like("0-23 hour", false){let(:hour){FactoryGirl.create :hour, hour: 24}}
  it_should_behave_like("0-23 hour", false){let(:hour){FactoryGirl.create :hour, hour: 25}}
end
