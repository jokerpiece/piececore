## Add .gitignore
git add .gitignore  
git commit -m "Add .gitignore"

## Remove local project files
echo "Removing local project files"  
LIST=`git ls-files -i --exclude-from=.gitignore`

for i in $LIST  
do  
echo $i  
git rm -f --cached $i  
done

## Commit local removal.
#例外のファイルを除外する処理がないので、手動で戻してからコミットしてね
#git commit -m "Remove local project files from git"