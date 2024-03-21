# == Schema Information
#
# Table name: master_system_settings
#
#  id         :bigint           not null, primary key
#  key        :string(255)      not null
#  name       :string(255)      not null
#  note       :text(65535)      not null
#  remarks    :text(65535)      not null
#  value      :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_master_system_settings_on_key  (key) UNIQUE
#
RSpec.describe Master::SystemSetting, type: :model do
  let!(:spec_system_settings) { Rails.root.join("spec/files/yml/spec_system_settings.yml") }
  describe ".defines" do
    it "テストファイルの設定をもとに、デフォルト値が設定されていること" do
      Master::SystemSetting.defines(spec_system_settings)

      setting = Master::SystemSetting

      aggregate_failures do
        # テストファイルで定義されているもの
        expect(setting.is_foo).to eq true
        expect(setting.is_bar).to eq false
        expect(setting.tax).to eq 0.23
        expect(setting.age).to eq 18
        expect(setting.greeting).to eq "hello"
        expect(setting.bccs).to eq ["a@example.com", "b@example.com", "c@example.com"]

        # 本番で定義されているもの
        expect(setting.is_maintenance).to eq false
        expect(setting.sales_tax).to eq 0.1
      end
    end
  end

  describe ".reset_seed!" do
    context "(本番データのとき)" do
      it "各種データが作成されていること" do
        expect { Master::SystemSetting.reset_seed! }.not_to raise_error

        aggregate_failures do
          # is_maintenance
          is_maintenance = Master::SystemSetting.find_by(key: "is_maintenance")
          expect(is_maintenance).to be_present
          expect(is_maintenance.__send_value__).to eq "off"
          expect(is_maintenance.key).to eq "is_maintenance"
          expect(is_maintenance.name).to eq "メンテナンスモード"
          expect(is_maintenance.note).to eq "「on」を指定することでシステムをメンテナンス中にできます。このとき、スーパーユーザ以外はシステムを操作できなくなります。"
          expect(is_maintenance.remarks).to eq "「on」「off」のどちらを指定してください"

          # sales_tax
          sales_tax = Master::SystemSetting.find_by(key: "sales_tax")
          expect(sales_tax).to be_present
          expect(sales_tax.__send_value__).to eq "0.1"
          expect(sales_tax.key).to eq "sales_tax"
          expect(sales_tax.name).to eq "消費税"
          expect(sales_tax.note).to eq "消費税を小数点(%ではありません)で指定してください。"
          expect(sales_tax.remarks).to eq "例えば0.1を指定すると 10% という意味になります。"
        end
      end
    end

    context "(テストデータのとき)" do
      it "テストファイルの設定をもとに、各種データが作成されていること" do
        expect { Master::SystemSetting.reset_seed!(spec_system_settings) }.not_to raise_error

        aggregate_failures do
          # is_foo
          is_foo = Master::SystemSetting.find_by(key: "is_foo")
          expect(is_foo).to be_present
          expect(is_foo.__send_value__).to eq "on"
          expect(is_foo.key).to eq "is_foo"
          expect(is_foo.name).to eq "is_foo_name"
          expect(is_foo.note).to eq "is_foo_note"
          expect(is_foo.remarks).to eq "is_foo_remarks"

          # is_bar
          is_bar = Master::SystemSetting.find_by(key: "is_bar")
          expect(is_bar).to be_present
          expect(is_bar.key).to eq "is_bar"
          expect(is_bar.name).to eq "is_bar_name"
          expect(is_bar.note).to eq "is_bar_note"
          expect(is_bar.remarks).to eq "is_bar_remarks"

          # tax
          tax = Master::SystemSetting.find_by(key: "tax")
          expect(tax).to be_present
          expect(tax.__send_value__).to eq "0.23"
          expect(tax.key).to eq "tax"
          expect(tax.name).to eq "tax_name"
          expect(tax.note).to eq "tax_note"
          expect(tax.remarks).to eq "tax_remarks"

          # age
          age = Master::SystemSetting.find_by(key: "age")
          expect(age).to be_present
          expect(age.__send_value__).to eq "18"
          expect(age.key).to eq "age"
          expect(age.name).to eq "age_name"
          expect(age.note).to eq "age_note"
          expect(age.remarks).to eq "age_remarks"

          # greeting
          greeting = Master::SystemSetting.find_by(key: "greeting")
          expect(greeting).to be_present
          expect(greeting.__send_value__).to eq "hello"
          expect(greeting.key).to eq "greeting"
          expect(greeting.name).to eq "greeting_name"
          expect(greeting.note).to eq "greeting_note"
          expect(greeting.remarks).to eq "greeting_remarks"

          # bccs
          bccs = Master::SystemSetting.find_by(key: "bccs")
          expect(bccs).to be_present
          expect(bccs.__send_value__).to eq "a@example.com,b@example.com,c@example.com"
          expect(bccs.key).to eq "bccs"
          expect(bccs.name).to eq "bccs_name"
          expect(bccs.note).to eq "bccs_note"
          expect(bccs.remarks).to eq "bccs_remarks"
        end
      end
    end
  end
end