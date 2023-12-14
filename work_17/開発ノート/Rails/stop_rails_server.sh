ps ax | grep rails | cut -d ' ' -f1 | xargs kill -9
