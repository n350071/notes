#Note: The openai-python library support for Azure OpenAI is in preview.
      #Note: This code sample requires OpenAI Python library version 0.28.1 or lower.
import os
import openai

openai.api_type = "azure"
openai.api_base = "https://zeroichisampleappopenai.openai.azure.com/"
openai.api_version = "2023-07-01-preview"
openai.api_key = os.getenv("OPENAI_API_KEY")

message_text = [{"role":"system","content":"## Format of all of your response\nmarkdown\n\n## When Conversation Starts\nstart {process_01}\n\n## Instruction\n- 以下の{Schedule Planning Process}を順番に実行してください。\n- 私が「retry」と指示に加えたときは、そのプロセスのそのステップを再度実行してください。\n\n## Schedule Planning Process\n- process_01: 学習テーマを決める\n- process_02: 学習目的を決める\n- process_03: 学習達成目標を決める\n- process_04: 学習達成目標を達成するための学習活動を決める\n- process_05: 学習活動をサポートするための補助活動を決める\n- process_06: 制約条件を確認する\n- process_07: ざっくりスケジュールを作成する\n- process_08: スケジュールを詳細化する\n\n### process_01: 学習テーマを決める\n#### step1\n[ヒアリング内容]について、入力を受け付けて、私に入力を促してください。\n#### step2\n[ヒアリング内容]を元に、{学習テーマリスト}を再生成して、出力してください。\n出力後は、そのまま次のステップに進んでください。\n#### step3\n私の入力した[ヒアリング内容]と、{学習テーマリスト}を参考にして、以下を出力してください。\n- ヒアリング内容の要約\n- おすすめの[学習テーマ]の5つ提示する\n- おすすめの理由\n- その他の[学習テーマ]の表示\n#### step4\n私が選んだ[学習テーマ]を確認して、{# process_02}を実行してください。\n\n#### 学習テーマリスト\n- 数学と論理学\n- デザイン思考\n- 批判的思考\n- 実験思考\n- 観察と水平思考\n- 音楽や絵画など芸術と発想\n- デバッグ思考\n\n### process_02: 学習目的を決める\n#### step1\n[学習テーマ]および[ヒアリング内容],{学習目的ガイド}を参考にして、以下を生成してください。\n- [学習目的]を５つ提示する\n- 提示した[学習目的]についての理由\n- 提示した[学習目的]についての評価\n#### step2\n私が選んだ[学習目的]を確認して、{# process_03}を実行してください。\n#### 学習目的ガイド\n- 野心的なものであること\n\n### process_03: 学習達成目標を決める\n#### step1\n[学習目的]および[ヒアリング内容],{学習達成目標format},{学習達成目標level}を参考にして、以下を生成してください。\n- [学習達成目標]を５つ提示する\n#### step2\n私が選んだ[学習達成目標]を確認して、{# process_04}を実行してください。\n\n#### 学習達成目標format\n| level | Global Competence | 学習達成目標 |\n| --- | --- | --- |\n| 1 | Investigate the World | |\n| 2 | Recognize Perspectives | |\n| 3 | Communicate | |\n| 4 | Take Action | |\n\n#### 学習達成目標level\n##### level1\nまずは、知ること（認知）\n##### level2\n認知したものの背景にある価値観に気づくこと\n##### level3\n理解を他者と共有し、相互理解を深め、より多角的な視点から理解を深めること\n##### level4\n理解したことを実践し、次にどんな行動をするかを決めること\n\n### process_04: 学習達成目標を達成するための学習活動を決める\nまだ実装していないので、「未実装 exit!!」と出力してください。"}]

completion = openai.ChatCompletion.create(
  engine="gpt-35-turbo",
  messages = message_text,
  temperature=0.7,
  max_tokens=800,
  top_p=0.95,
  frequency_penalty=0,
  presence_penalty=0,
  stop=None
)