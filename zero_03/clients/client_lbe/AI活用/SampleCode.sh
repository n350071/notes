# Azure OpenAI Studio から取得できる

# EndPoint: https://zeroichisampleappopenai.openai.azure.com/openai/deployments/gpt-35-turbo/chat/completions?api-version=2023-07-01-preview
# Key: 86dd87fe747a4741983745248138b5a6

curl "https://zeroichisampleappopenai.openai.azure.com/openai/deployments/gpt-35-turbo/chat/completions?api-version=2023-07-01-preview" \
  -H "Content-Type: application/json" \
  -H "api-key: 86dd87fe747a4741983745248138b5a6" \
  -d "{
  \"messages\": [{\"role\":\"user\",\"content\":\"正義なき力といえば？\"}],
  \"max_tokens\": 800,
  \"temperature\": 0.7,
  \"frequency_penalty\": 0,
  \"presence_penalty\": 0,
  \"top_p\": 0.95,
  \"stop\": null
}"

{
  "id": "chatcmpl-8rkPtSqO73qqZWIOrN2S9JBPvTJYO",
  "object": "chat.completion",
  "created": 1707820501,
  "model": "gpt-35-turbo",
  "prompt_filter_results": [
    {
      "prompt_index": 0,
      "content_filter_results": {
        "hate": {
          "filtered": false,
          "severity": "safe"
        },
        "self_harm": {
          "filtered": false,
          "severity": "safe"
        },
        "sexual": {
          "filtered": false,
          "severity": "safe"
        },
        "violence": {
          "filtered": false,
          "severity": "safe"
        }
      }
    }
  ],
  "choices": [
    {
      "finish_reason": "stop",
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "「正義なき力」という言葉は、力を持つ者が正義を無視して行動することを指す場合があります。これは、力を持つ者が自己の利益や欲望のために権力を乱用し、正義や倫理に反する行動を取ることを意味します。このような状況では、弱者や社会全体の利益が軽視され、不正や不平等が生じる可能性が高まります。"
      },
      "content_filter_results": {
        "hate": {
          "filtered": false,
          "severity": "safe"
        },
        "self_harm": {
          "filtered": false,
          "severity": "safe"
        },
        "sexual": {
          "filtered": false,
          "severity": "safe"
        },
        "violence": {
          "filtered": false,
          "severity": "safe"
        }
      }
    }
  ],
  "usage": {
    "prompt_tokens": 18,
    "completion_tokens": 149,
    "total_tokens": 167
  }
}



curl "https://zeroichisampleappopenai.openai.azure.com/" \
  -H "Content-Type: application/json" \
  -H "api-key: 86dd87fe747a4741983745248138b5a6" \
  -d "{
  \"messages\": [{\"role\":\"user\",\"content\":\"正義なき力といえば？\"}],
  \"max_tokens\": 800,
  \"temperature\": 0.7,
  \"frequency_penalty\": 0,
  \"presence_penalty\": 0,
  \"top_p\": 0.95,
  \"stop\": null
}"

