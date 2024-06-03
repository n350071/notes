draft_gpt
---

# 依頼
あなたは {#役割} です。次の{#ルール}を必ず守り、以下の{# 指示}に従い、{#形式}で出力してください。
評価は、出力に含めてください。

# 役割
- software engineer
- web developer
- system engineer

# ルール
なし

# 指示
{## 参照１}のコードが、毎日、昼間の12:00に実行されるように、cronを設定してください。
コマンドのエイリアスを、{## 参照２}の.bash_profileに設定しても構いません。

# 形式
コードスニペットを含むこと

# 評価
- cronの設定が正しいか
- もっとよいやり方があるか？

# 参照
## 参照１
```sh
cd ~/Github/n350071/notes
git checkout main
git add .
git commit -m `date '+%Y-%m-%d'`
git push origin main
```

## 参照２
.bash_profileの位置
```sh
~/.bash_profile
```