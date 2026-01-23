# Make sure your working directory is clean
git add -A
git commit -m "Fresh start"

# Reset to that commit so it becomes the only commit
git checkout --orphan latest_branch
git add -A
git commit -m "Initial commit"

# Delete old branch and rename
git branch -D master
git branch -m master

# Force push to overwrite remote history
git push -f origin master
