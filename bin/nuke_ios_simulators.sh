
read -p "Are you sure you want toe remove all the simulators? [Y]" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Removing simulators..."
  UUID_REGEX='[0-9A-F]\{8\}-[0-9A-F]\{4\}-[0-9A-F]\{4\}-[0-9A-F]\{4\}-[0-9A-F]\{12\}'
  xcrun simctl list devices | grep "$UUID_REGEX" -o | xargs xcrun simctl delete '{}'
fi


