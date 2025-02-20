# 👍 廃止された actions/cache@v1, v2 を actions/cache@v4 へアップデート #755

mizuno
  23:24
@ishigaki

【共有】
サンエスラインもCI落ちることがあるかもしれません。
もし actiton/cache が原因で落ちるようでしたら、以下参考に修正するとなおるかもです！

https://github.com/zeroichi-hacker/eshub/pull/755

---

- 目的
  - CIを引き続き使えるようにするため
- 背景
  - Github Action 実行時に以下のエラーが発生した
    - `This request has been automatically failed because it uses a deprecated version of actions/cache: v1. Please update your workflow to use v3/v4 of actions/cache to avoid interruptions. Learn more: https://github.blog/changelog/2024-12-05-notice-of-upcoming-releases-and-breaking-changes-for-github-actions/#actions-cache-v1-v2-and-actions-toolkit-cache-package-closing-down. This request has been automatically failed because it uses a deprecated version of actions/cache: v2. Please update your workflow to use v3/v4 of actions/cache to avoid interruptions. Learn more: https://github.blog/changelog/2024-12-05-notice-of-upcoming-releases-and-breaking-changes-for-github-actions/#actions-cache-v1-v2-and-actions-toolkit-cache-package-closing-down`
  - 要約すると v1, v2 のキャッシュが使えなくなったので v3かv4にあげて欲しいということだった
- 詳細
  - actions/cache@v1, v2 を使っているところを v4 へ変更

---

## commit id
06e7949235f7916ee50920cb8c4edd3a64ffddef