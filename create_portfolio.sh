#!/bin/zsh

echo "Hi there! What's your name?"
read NAME

echo "And what year are you in, $NAME?"
read YEAR

echo "Please describe yourself in one sentence!"
read SUMMARY

echo Building your site...
DIR="../autosite/$NAME-$YEAR"
mkdir $DIR
cp template.html "$DIR/index.html"
cp template.css "$DIR/style.css"

# replacing stuff
sed -i '' "s/template\.css/style\.css/g" "$DIR/index.html"
sed -i '' "s/VAR_NAME/$NAME/g" "$DIR/index.html"
sed -i '' "s/VAR_SUMMARY/$SUMMARY/g" "$DIR/index.html"

# create git project
echo Initializing git
cd $DIR
git init -b main
git stage *
git commit -m "🥳 initial commit"

# create gh project
gh repo create "uoftweb/$NAME" --source=. --public --push
echo Done creating project, turn on pages to go public!
open "https://github.com/uoftweb/$NAME/settings/pages"