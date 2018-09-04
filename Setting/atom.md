# atom
## install

- apm install react
- apm install maximize-panes
- apm install convert-to-utf8
- apm install auto-encoding
- apm install [split-diff](https://atom.io/packages/split-diff)
- apm install [https://github.com/mfripp/atom-tablr.git](https://github.com/abe33/atom-tablr/issues/100#issuecomment-406904774) A
- apm install [atom-csv-markdown](https://atom.io/packages/atom-csv-markdown)
- apm install [teletype](https://github.com/atom/teletype) https://teletype.atom.io/

## keymap (cson)
```
'window:focus-pane':
  'cmd-k cmd-left': 'window:focus-pane-left'
  'cmd-k cmd-right': 'window:focus-pane-right'
  'cmd-k cmd-below': 'window:focus-pane-below'
  'cmd-k cmd-up': 'window:focus-pane-above'

# cmd-k-b : tree-view:toggle
'.platform-darwin':
  'cmd-shift-t' :	'tree-view:toggle'
```

## keymap for just remember

 Feature | keymap_
-- | --
markdown preview | ctrl-shift-M
encoding | ctrl-shift-u
diff   | ctrl-alt-t

## Find in Project
To ignore some directory..,
```
!vendor
```
