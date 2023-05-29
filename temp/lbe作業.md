# lbe作業.md

## fileの添付が必須のものは、添付しないと送信不可にする
- ✅廃止: props.localTransportExpense
- ✅導入: localTeStates, extraTeStates, ...
- ✅導入: const totalFare (TeInput)
- ✅導入: reducer
  ✅- localTeCallbackReducer
    - fareの入力があったときに、localTeStatesを書き換える
    - isLocalTeStatesValidを書き換える
- ✅導入: 各種valid
  - isLocalTeStatesValid, isExtraTeStatesValid
- ✅導入: valid
  - 各種validがすべてtrueなら、true
- file追加時のコールバック


## fileの添付ができないときの、チェックボックス
- ✅導入: チェックボックス
- ✅導入: type: localTeStates
  - ✅noFile: boolean
- ✅修正:
  - ✅reducer
  - ✅各種valid
    - ✅noFileがついていたら、送信可（true）にする

領収書がない場合には、チェックボックス等で、ない旨を伝えつつ、Routeにその理由を書くように案内言葉を書く


- file changed!
- index.js:548 [webpack-dev-server] "/app/public/uploads/d66dc3f2f7f9/programs/join_leaders/transport_expense/file/10/5490fa94-7d18-be5f-1a4e-d76346d24775.png" from static directory was changed. Reloading...

