describe 'Part' do

  require 'spec_helper'
  require File.basename(__FILE__).sub('_spec.rb','')

  attr_reader :bycycle, :front_tire, :rear_tire, :frame, :gear, :low_gear, :middle_gear, :high_gear

  before :each do
    @bycycle = Part.new('bycycle')
    @front_tire = Part.new('tire',80,bycycle)
    @rear_tire = Part.new('tire',60,bycycle)
    @frame = Part.new('frame',10,bycycle)
    @gear = Part.new('gear',30,frame)
    @low_gear = Part.new('gear',40,gear)
    @middle_gear = Part.new('gear',90,gear)
    @high_gear = Part.new('gear',80,gear)
  end

  describe 'initialize' do
    example 'make a product' do
      expect(bycycle.children).to eq [front_tire,rear_tire,frame]
    end
  end

  describe 'find_parts_by_name' do
    it 'counts number of the parts by name' do
      expect(bycycle.find_parts_by_name('tire')).to eq 2
      expect(bycycle.find_parts_by_name('gear')).to eq 4
    end
  end

  describe 'find_damaged_parts' do
    it 'counts number of the parts by damage' do
      expect(bycycle.find_damaged_parts(50)).to eq 4
      expect(bycycle.find_damaged_parts(80)).to eq 3
    end
  end

end
