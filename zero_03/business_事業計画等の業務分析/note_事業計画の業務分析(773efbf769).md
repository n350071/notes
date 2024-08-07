note_事業計画の業務分析(773efbf769)
---

- 経営と事業の違い(272e8731bb)

---
# onCreate
## responsibility
- 事業戦略・財務計画を決める
## context(inputのもとになる業務や背景)
## input
省略
## process
省略
## output
- 事業計画書(6e27b87611)
  - 業種
  - 事業開始日
  - 創業者・創業メンバーのプロフィール（Why you?）
  - Mission-Vision-Value
  - 取扱商品・サービス
  - セールスポイント（自社サービスの強み・特徴・優位性）
  - 市場環境・競合について
  - マーケティング戦略
  - 生産方法・仕入先など
  - Going Concernの前提と撤退戦略
    - 動的平衡チェックシート（１年間の大丈夫？）
      - 勝ちパターン
      - GCチェック
      - 財務計画チェック
    - 撤退戦略
  - 財務計画（事業の見通し・判断）(8e4bc69413)
    - 売上計画
    - 利益計画
    - 投資調達
    - 資金計画
    - CF計画
  - 施策ボード
    - リスクや問題点・機会
    - バックログ
## integration
- 各部門への連携
  - 営業（セールス）
  - マーケ
  - ..etc

---
# onUpdate
## responsibility
- 事業のリスクや問題点を早く検知し、事業の軌道修正を行うか、早めの対処を行う
## context(inputのもとになる業務や背景)
## input
リスクや問題点・機会を検知する目的で以下を入力する
- 事業計画書
  - update
    - 財務計画
      - 実績と分析とシミュレーションの報告
    - 施策ボード
      - 今月の進捗をYWMA(やったこと・わかったこと・メトリクス・アクション)で報告
- 営業
  - 案件管理表（問い合わせ件数・案件進捗・売上予測と実績・リソース管理）

## process
- 動的平衡チェックと撤退判断
- 施策ボードの確認と更新

## output
- 更新された事業計画書
  - 財務計画
    - 明瞭で見通しのよい会計情報
  - 施策ボード
    - 調整・修正された事業戦略
  - その他
    - 施策により変更されうる

## integration
- 各部門への連携
  - 営業（セールス）
  - マーケ
  - ..etc





---
# old
## context(inputのもとになる業務や背景)
## input
- 事業計画書（１年間の地図）定量的 (8e4bc69413)
- 動的平衡チェックシート（１年間の方位磁針）定性的
- 案件管理表（案件進捗・売上予測と実績・リソース管理・リスク管理）定量的
- 現在の事業戦略
  - 戦略目標
  - 今月のYWMA(やったこと・わかったこと・メトリクス・アクション)

## process
- 動的平衡
  - お金大丈夫？（１年間大丈夫？）
  - 継続できる？（１年間大丈夫？）
  - リソース大丈夫？（１年間大丈夫？）
- 事業戦略
  - 方向性合ってる？
  - 進んでる？

## output
- 明瞭で見通しのよい会計情報
- 調整・修正された事業戦略
- 各部門への指示

## integration
- 営業（案件管理・売上予測・売上実績）
- マーケ（マーケとブランディング・CRM・広報）
- 財務
- 経理





