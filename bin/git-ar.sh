
branch=$1

if [ $branch == "-q" ] || [ $branch == "-l" ]
then
  git tag -l archive/*
  exit 0
fi



git rev-parse --verify $branch
status=$?

if [ $status != 0 ] 
then
  echo "Error: branch does not exist"
  exit 1
fi

git tag archive/$branch $branch
git branch -D $branch

