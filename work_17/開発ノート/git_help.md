# open changed files
git diff HEAD^ --name-only | xargs atom

# 取り消したい
git commit --amend --no-edit # 登録されたインデックスを直前のコミットにまとめる

# git diff for staged files
git diff --cached

# git log
git log --oneline --graph
git log --name-status
git log -n 3
git log --since="4 days ago" --until="2015/01/22"
git log  -- path/to/*.rb
git log --author='name'
git log --no-merges
git log --first-parent
git log --grep hoge
git log -p -S xxx # see commits that include changes with xxx
git log -p -S xxx --pickaxe-all # with all files
git log --oneline --graph --pretty=format:"[%ad] %cn %s %h"

# git blame
git blame TargetFile|grep TargetWord|cut -d " " -f 1|xargs git show
git blame TargetFile|peco|cut -d " " -f 1|xargs git show

# git branch
## is it merged?
git branch --merged master     # show branchs that is merged     -> ok to delete
git branch --no-merged master  # show branchs taht is not merged -> not ok to delete
git branch --merged | egrep -v 'master' | xargs git branch -d #マージ済みのブランチを削除しよう
## delete
git branch -d [branch name]
## rename
git branch -m [new name] || git branch -m [new name] [old name]
git push origin :[old name] # remove old branch in remote
git push origin [new name]  # done to rename

# upstrem
git remote -v
git fetch upstrem
git rebase upstream/master
git pull --rebase upstream master

# git remote
git remote add origin <url>
git remote add github <url>
git remote -v
git remote rename origin destination
# change the git remote 'push to' default
git push -u <remote_name> <local_branch_name>
# delete remote branches of not upstream
git branch --remote | grep -v "upstream" | egrep -v "origin/master|origin/deployment" | xargs git branch -dr
git branch -a
git fetch
git checkout -b other_branch origin/other_branch

# git emoji commit
#`commit.template`ファイルを追加した上で、
# 以下の設定を `.git/config` に記載しておくと `git commit` で確認することができます。
```
[commit]
 	template = commit.template
```

# search all remote branches for search-string.
# git grep 'search-string' $(git ls-remote . 'refs/remotes/*' | cut -f 2)
git grep 'search-string' $(git ls-remote . 'refs/remotes/*' | grep -v HEAD | cut -f 2)
git grep 'search-string' $(git rev-list --all)


# check conflict before merge
git merge --no-commit branch2
git merge --abort # check the return code here

# マージコミットをrevertして幹の方を残す(mergeされる側は2を選択)
git revert -m 1 7143dc9d8d835efa3012e9ad624c75965297ee88 -n
git revert --continue

# マージの複雑なコンフリクトのときに使う
git checkout --conflict=diff3 file.rb # Baseコンフリクトマーカーも表示する
git checkout --conflict file.rb # コンフリクトマーカーの書き直し

# make empty github pullrequest
git commit --allow-empty -m #{プルリクエストのタイトル}
git push origin #{ブランチ名}
git branch -u origin/#{リモートブランチ名}
git branch -vv


# git cloneする際のディレクトリに名前をつける
git clone git@github.com:nao0515ki/rails-on-k8s.git rails-on-k8s-refactor

# git コミットメッセージからマージ元ブランチを特定する（原始的バージョン）
## --more= の数字を適当に切り替える
git show-branch --more=400 master | grep 'hoge'
## [master~70^2~3] hoge というような行がみつかるので、、その数字でもういちど実行してスクロールすると、見つけられる
git show-branch --more=400 master
## [master~70] Merge pull request #306 from organize/branch-name
## [master~70^2] buzz
## [master~70^2^] fizz
## [master~70^2~2] fuga
## [master~70^2~3] hoge
