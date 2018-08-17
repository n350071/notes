describe "Message" do

  require 'spec_helper'
  require File.basename(__FILE__).sub('_spec.rb','')

  attr_reader :message

   before :each do
     @message = Message.new
   end

  describe 'say_thank_you' do
    it 'should say thank you with the day' do
      time = Time.mktime(0,0,0,1,1,2018,0,0,false,'JST')
      expect(message.say_thank_you(time)).to eq 'Date: 20180101 thank you'
    end
  end
  describe 'say_have_a_nice_day' do
    it 'should say have a nice day with the day' do
      time = Time.mktime(0,0,0,1,1,2018,0,0,false,'JST')
      expect(message.say_have_a_nice_day(time)).to eq 'Date: 20180101 have a nice day'
    end
  end

end
