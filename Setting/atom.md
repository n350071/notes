# atom
## install
apm install react
apm install maximize-panes
apm install convert-to-utf8
apm install auto-encoding

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

## Find in Project
To ignore some directory..,
```
!vendor
```
