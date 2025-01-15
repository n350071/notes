以下に、配列の JSON データ形式を表現する例を示します。

---

### 1. YARD コメントでの記法

YARD を使ってデータ形式を説明する場合、以下のように記述します。

```ruby
# @param [Array<Hash>] data 配列内に複数のハッシュを含むデータ
#   [
#     {name: "太郎", operation: "10", promotion: "15", glt: "0", prepare: "30"},
#     {name: "花子", operation: "12", promotion: "18", glt: "1", prepare: "25"}
#   ]
# @return [Boolean] 保存が成功したかどうか
def save_data(data)
  # 実装
end
```

- `@param` はメソッドの引数を説明します。
  - `[Array<Hash>]` は、「配列の中にハッシュを含む」という型を指定します。
  - ハッシュ内の具体的なフィールドを詳細に記述する場合はコメントに例を記載できます。
- `@return` はメソッドの戻り値を説明します。

---

### 2. RBS（Ruby Signature）による記法

Ruby 3 以降では、静的型解析のための **RBS** を利用することができます。この場合、型を以下のように定義できます。

```rbs
# メソッドの型定義
def save_data: (Array[{name: String, operation: String, promotion: String, glt: String, prepare: String}]) -> bool
```

この例では：
- `Array[{name: String, operation: String, promotion: String, glt: String, prepare: String}]` は、配列内に指定されたキーと値のペアを持つハッシュが含まれることを表しています。
- `-> bool` は、戻り値が `Boolean` 型であることを示します。

RBS を使うと、データ形式がより厳密に定義されます。

---

### 3. JSON Schema を利用した記法

もし API の設計や外部連携で使用する場合は、 **JSON Schema** を使うとデータ形式を簡潔に表現できます。

```json
{
  "type": "array",
  "items": {
    "type": "object",
    "properties": {
      "name": { "type": "string" },
      "operation": { "type": "string" },
      "promotion": { "type": "string" },
      "glt": { "type": "string" },
      "prepare": { "type": "string" }
    },
    "required": ["name", "operation", "promotion", "glt", "prepare"]
  }
}
```

---

### 4. コメントだけで説明する

型注釈ツールを使わない場合は、シンプルにコメントで形式を説明することもあります。

```ruby
# dataは以下の形式の配列
# [
#   {name: "太郎", operation: "10", promotion: "15", glt: "0", prepare: "30"},
#   {name: "花子", operation: "12", promotion: "18", glt: "1", prepare: "25"}
# ]
def save_data(data)
  # 実装
end
```

---

### 選び方

- **YARD コメント** は、Ruby 開発のドキュメント生成に適しており、特にチームでの開発に便利です。
- **RBS** は型を厳密に管理したい場合に有効で、静的型解析を導入している場合に最適です。
- **JSON Schema** は、API の仕様を外部に公開する場合や、データバリデーションを説明する際に向いています。

用途やプロジェクトに合わせて最適な記法を選択してください！