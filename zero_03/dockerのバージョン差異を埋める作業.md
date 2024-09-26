dockerのバージョン差異を埋める作業
---

## 背景
- 開発環境(Macbook Air M2)
  - Docker version 27.2.0, build 3ab4256
- 本番環境(AWS EC2)
  - Docker version 20.10.22, build 3a2c30b

## 方針
本番環境のDockerバージョンを変更しない。
開発環境も変更しない。
開発環境に、ラッパースクリプトを作成して、本番環境と同じように動作するようにする。

## 作業手順




---
お困りの状況を理解しました。`docker-compose` のインストールがうまくいかないため、エイリアスなどを使って開発環境で `docker-compose` コマンドを再現したいということですね。

**解決策：開発環境でエイリアスまたはラッパースクリプトを使用する**

開発環境で `docker-compose` コマンドを `docker compose` に置き換える方法を提案します。これにより、既存の `docker-compose` コマンドや `docker-compose.yml` ファイルを変更せずに、本番環境との互換性を保つことができます。

### **方法1：エイリアスを使用する**

1. **シェルの設定ファイルにエイリアスを追加**

   - 使用しているシェルに応じて、以下の設定ファイルを編集します：

     - Bashの場合：`~/.bashrc` または `~/.bash_profile`
     - Zshの場合：`~/.zshrc`

   - ファイルの最後に以下の行を追加します：

     ```bash
     alias docker-compose='docker compose'
     ```

2. **設定を反映する**

   - ターミナルを再起動するか、以下のコマンドを実行します：

     ```bash
     source ~/.bashrc   # Bashの場合
     source ~/.zshrc    # Zshの場合
     ```

3. **動作確認**

   - `docker-compose` コマンドを実行して、期待通りに動作するか確認します。

     ```bash
     docker-compose --version
     ```

     - 新しい `docker compose` のバージョン情報が表示されれば成功です。

**注意点：**

- エイリアスはインタラクティブなシェルでのみ有効です。スクリプトや Makefile 内ではエイリアスが適用されない場合があります。

### **方法2：ラッパースクリプトを作成する（推奨）**

エイリアスの制限を回避するため、`docker-compose` コマンドを再現するラッパースクリプトを作成します。

1. **`~/bin` ディレクトリを作成**

   ```bash
   mkdir -p ~/bin
   ```

2. **`~/bin` を PATH に追加**

   - シェルの設定ファイルに以下の行を追加します：

     ```bash
     export PATH=~/bin:$PATH
     ```

   - 設定を反映します：

     ```bash
     source ~/.bashrc   # Bashの場合
     source ~/.zshrc    # Zshの場合
     ```

3. **ラッパースクリプトを作成**

   - `docker-compose` という名前のファイルを作成します：

     ```bash
     touch ~/bin/docker-compose
     chmod +x ~/bin/docker-compose
     ```

   - ファイルに以下の内容を追加します：

     ```bash
     #!/bin/bash
     docker compose "$@"
     ```

   - これにより、`docker-compose` コマンドが `docker compose` に引数を渡して実行されます。

4. **動作確認**

   ```bash
   docker-compose --version
   ```

   - 新しい `docker compose` のバージョン情報が表示されれば成功です。

### **`version` フィールドの警告を無視する**

- **警告メッセージの扱い**

  - 新しい `docker compose` コマンドは `version` フィールドを無視しますが、これは警告であり、エラーではありません。
  - 本番環境では `version` フィールドが必要なため、開発環境では警告を無視してそのまま使用できます。

- **警告を非表示にする（任意）**

  - 警告メッセージが気になる場合は、コマンドの出力を調整することで非表示にできます。

    ```bash
    docker-compose up 2>/dev/null
    ```

    - ただし、他の重要なエラーメッセージも非表示になる可能性があるため、注意が必要です。

### **Makefile の修正（必要に応じて）**

- **エイリアスがスクリプト内で機能しない場合**

  - Makefile 内で `docker-compose` を使用している場合、ラッパースクリプトを作成していれば変更は不要です。
  - もしエイリアスを使用していて、エイリアスが適用されない場合は、Makefile を以下のように修正します：

    ```makefile
    ifeq ($(shell command -v docker-compose),)
        DOCKER_COMPOSE_COMMAND = docker compose
    else
        DOCKER_COMPOSE_COMMAND = docker-compose
    endif

    up:
        $(DOCKER_COMPOSE_COMMAND) up -d
    ```

    - これにより、環境に応じて適切なコマンドが使用されます。

### **まとめ**

- **開発環境でラッパースクリプトを作成する**ことで、`docker-compose` コマンドをそのまま使用できます。
- **本番環境への影響はありません**。開発環境のみの変更で済みます。
- **警告メッセージは無視しても問題ありません**。必要に応じて非表示にすることも可能です。

---

