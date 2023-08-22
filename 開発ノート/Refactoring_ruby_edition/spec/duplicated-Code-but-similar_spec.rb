describe 'Messagnger' do

  require 'spec_helper'
  require File.basename(__FILE__).sub('_spec.rb','')

  attr_reader :messanger

  describe 'Blue_msger' do
    describe 'open_chat' do
      it 'returns some words' do
        time = Time.now
        expect(Blue_msger.new.open_chat(time)).to eq "#{time.strftime "%Y%m%d"} Hello! World!This is the blue messanger!"
      end
    end
  end
  describe 'Green_msger' do
    describe 'open_chat' do
      it 'returns some words' do
        time = Time.now
        expect(Green_msger.new.open_chat(time)).to eq "#{time.strftime "%Y%m%d"} Hello! World!This is the green messanger!"
      end
    end
  end
end
