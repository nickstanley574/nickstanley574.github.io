```
git filter-branch --tree-filter 'rm path/to/your/bigfile' HEAD
git push origin master --force
```