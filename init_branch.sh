git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/stephnangue/movies-parser.git
git push -u origin main
git checkout -b preprod
git push origin preprod
git checkout -b develop
git push origin develop
git branch -d main
