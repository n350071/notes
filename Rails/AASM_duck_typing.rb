# set a array of prevent events into the &block
# example: update_status!(event){['set_up','ready']}
# `set_up` is valid event in AASM, but this event won't be allowed
# to update the status.
def update_status!(event, &block)
  return false if event == nil
  if block.present?
    return false if yield.include?(event)
  end
  if self.aasm(:default).events(:permitted => true).map(&:name).include?(event.to_sym)
    self.send(event.to_s + "!")
  else
    false
  end
end

# example
def api_status_service(event)
  begin
    if self.update_status!(event){['event_2','event_5']} # they are not allowed from this api
      return {status: 204}
    else
      return {status: 400, body: '{"message" : "Bad Request"}'}
    end
  rescue
    return {status: 500, body: '{"message" : "Internal Server Error"}'}
  end
end



# rspec
describe 'update_status!' do
  let(:target){FactoryGirl.create :target}
  context 'invalid event' do
    let(:atack_event){:exit}
    it{expect(target.update_status!(atack_event)).to be_falsey}
  end
  context 'bang evnt' do
    let(:event){:finalize!}
    it{expect(target.update_status!(event)).to be_falsey}
  end
  context 'valid event' do
    let(:event){:finalize}
    it 'returns true' do
      expect(target.update_status!(event)).to be_truthy
    end
    it 'change the status in the DB' do
      target.update_status!(event)
      db_ope = Operation.find_by_id(target.id)
      expect(db_ope.status).to eq "ready"
    end
  end
end
