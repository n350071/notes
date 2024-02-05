AWS>CLIで、S3 からファイルをダウンロードする
---

## CLIで、S3 からファイルをダウンロードする
### template
```sh
aws s3 sync s3://your-bucket-name ./local-directory
```
### example
```sh
aws s3 sync s3://eventer-prototype ~/Downloads/s3/eventer-prototype
```

---

## ダウンロードしたファイルの拡張子を、一括でpngに変更する
change_extension.rb

```rb
require 'fileutils'

# 使用方法を表示する関数
def print_usage
  puts "使用方法: ruby change_extension.rb [ディレクトリパス] [現在の拡張子] [新しい拡張子]"
  puts "例: ruby change_extension.rb ./eventer-prototype/ nil png"
end

# 引数の数をチェック
unless ARGV.length == 3
  print_usage
  exit
end

dot = "."
directory_path, current_ext, new_ext = ARGV

puts "ディレクトリ: #{directory_path}"
puts "現在の拡張子: #{current_ext}"
puts "新しい拡張子: #{new_ext}"

if current_ext == "nil"
  current_ext = ""
  dot = ""
  puts "nil が指定されたため、拡張子を無視します。"
end

# 指定されたディレクトリを確認し、ファイルの拡張子を変更

# puts "Dir.globの結果: #{Dir.glob(File.join(directory_path, "*#{dot}#{current_ext}"))}"

Dir.glob(File.join(directory_path, "*#{dot}#{current_ext}")) do |file_path|
  puts "file_path: #{file_path}"
  if current_ext == ""
    new_file_path = file_path + ".#{new_ext}"
  else
    new_file_path = file_path.sub(/\.#{current_ext}$/, ".#{new_ext}")
  end
  puts "old: #{file_path}, new: #{new_file_path}"
  puts "✅✅✅✅✅"
  FileUtils.mv(file_path, new_file_path)
  puts "🔥🔥🔥🔥🔥"
  puts "#{file_path} を #{new_file_path} に変更しました。"
end

puts "指定された拡張子のファイル名を全て変更しました。"

```