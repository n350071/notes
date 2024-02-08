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