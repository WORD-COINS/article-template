for filepath in $PWD/articles/*; do
  cd $filepath
  if [ -f ./main.md ]; then
    echo $filepath
    make pandoc
  fi
done
