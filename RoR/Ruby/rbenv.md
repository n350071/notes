# rbenv: when `rbenv global` is differnt from `ruby -v`, it is because path is wrong, so do this.
```
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
```
