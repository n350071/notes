# atom
## install
apm install react
apm maximize-panes

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
- markdown preview
  - ```
  'atom-text-editor':
    'ctrl-shift-M': 'markdown-preview:toggle'
  ```
