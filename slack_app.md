# slack app


## Distribute
- Documents
  - [Using OAuth 2.0](https://api.slack.com/docs/oauth)
  - [Slack Button](https://api.slack.com/docs/slack-button)
  -
- Manage Distribution
  - Add OAuth Redirect URLs
    - you can change it later `https://api.slack.com/apps/xxxxxxxx/oauth?`
  - Get the request url
    - [you can get the slack app button](https://api.slack.com/apps/ACGE55EB0/distribute?)
    - it includes the url
      - ```
        https://slack.com/oauth/authorize?scope=incoming-webhook&client_id=387236884133.424481184374
        ```
- build the app and publish
  - (my tried it on Heroku)
- access to the url (above)
- slack redirect to the url you defined after the user accept with params
  - the url
    - ```https://slack-notify4124974.herokuapp.com/slack_oauth?code=387236884133.424182043495.70d4cb0455f2c5f492bad3cbffa9772054307f1350a609d0790c98431c574b1d&state=```
  - the params
    - `{"code"=>"387236884133.424182043495.70d4cb0455f2c5f492bad3cbffa9772054307f1350a609d0790c98431c574b1d", "state"=>"", "controller"=>"slack_oauth", "action"=>"redirect"}`
- Exchanges a temporary OAuth verifier code for an access token.
  - request
    - ```
      $curl -X POST \
           -H 'application/x-www-form-urlencoded' \
           -F 'code=387236884133.424182043495.70d4cb0455f2c5f492bad3cbffa9772054307f1350a609d0790c98431c574b1d' \
           -F 'client_id=387236884133.424481184374' \
           -F 'client_secret=32605411b2c14366ccd3c9d27a423df6' \
           https://slack.com/api/oauth.access
       ```
  - receive
    - ```
      {"ok":true,"access_token":"xoxp-------------------------","scope":"identify,incoming-webhook","user_id":"UBD-------","team_name":"team-----","team_id":"TB----","incoming_webhook":{"channel":"#xxxx-----","channel_id":"CC----","configuration_url":"https:\/\/team-----.slack.com\/services\/BG---","url":"https:\/\/hooks.slack.com\/services\/TB----\/BG---\/ILZXD"}}
      ```
  - in ruby code
    - ```
      # このメソッドの戻り値は以下の予定
      #=> {"ok"=>true, "access_token"=>"xoxp-------------------------", "scope"=>"identify,incoming-webhook", "user_id"=>"UBD-------", "team_name"=>"team-----", "team_id"=>"TB----", "incoming_webhook"=>{"channel"=>"#xxxx-----", "channel_id"=>"CC----", "configuration_url"=>"https://team-----.slack.com/services/BCF---", "url"=>"https://hooks.slack.com/services/TB----/BC------/O1--------"}}
      #=> {"ok"=>false, "error": "invalid_code"} <= テスト可能
      #=> {"ok"=>false, "error": "invalid_client_id"}
      # 詳細：https://api.slack.com/methods/oauth.access
      def resolve_code(code)
        res = Net::HTTP.post_form(URI('https://slack.com/api/oauth.access'),
                                  code:           code,
                                  redirect_uri:   "https://--------.jp/------/#{id}/slack_oauth",
                                  client_id:      ENV["SLACK_CLIENT_ID"],
                                  client_secret:  ENV["SLACK_CLIENT_SECRET"]
                                )
        JSON.parse(res.body)
      end
      ```
