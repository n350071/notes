# run rspec
bundel exec rspec spec/models/xxxx_spec.rb           ## specify specific file
bundel exec rspec spec/models/xxxx_spec.rb -e status ## specify a test in specific file

# ときどき、テスト用のDBが更新されていないときがある
# とくに rake db:rollbackしたあと
# そのときは、
# rake db:rollback RAILS_ENV=test
# rake db:migrate RAILS_ENV=test


# describeは、クラスやメソッドを書く
# contextに、条件を
# letとbeforeで条件にある前提条件を作る
# it/exampleに、実行結果と期待結果を書く
describe 'save' do
  context 'point is nil' do
    let(:something){FactoryGirl.build :something}
    before{something.point = nil}
    it{expect{something.save}.to change{ SomethingRelation.count }.by(0)}
  end
  context 'point is present' do
    let(:something){FactoryGirl.build :something}
    let(:point){[0,1,2]}
    before{something.point = point}
    it{expect{something.save}.to change{ SomethingRelation.count }.by(3)}
  end
end

# 変化の数を調べたいとき
it{expect{something.save}.to change{ SomethingRelation.count }.by(3)}

# mock
before{allow_any_instance_of(ClassName).to receive(:a_method).and_return('great!')}
before{allow_any_instance_of(ClassName).to receive(:a_method).and_raise(StandardError.new("error")) }
