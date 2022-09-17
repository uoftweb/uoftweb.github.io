#!/bin/zsh

echo "Hi there! What's your full name?"
read NAME

echo "And what year are you in, $NAME?"
read YEAR

echo "Please describe yourself in one sentence!"
echo "(ex: A first year student exploring web development)"
read TAGLINE

echo "Tell me a bit more about yourself.."
read ABOUTME

MEMBER="null"
while [[ "$MEMBER" != "yes" && "$MEMBER" != "no" ]]
do
    echo "Do you want to get involved as an official UofTWeb member? (yes/no)"
    read MEMBER
done

if [ "$MEMBER" != 'no' ]; then
    echo "What's your UofT Email Address?"
    read EMAIL

    echo "What's your student number?"
    read NUMBER

    echo "And finally, what college are you registered in?"
    read COLLEGE

    echo "$NAME,$EMAIL,$NUMBER,$COLLEGE" >>membership.csv
    echo "Thank you for becoming a member! Now to just finish up the site.."
fi

echo Building your site...
DIR="../autosite/$NAME-$YEAR"
mkdir $DIR
cp template.html "$DIR/index.html"
cp template.css "$DIR/style.css"
cp template.js "$DIR/main.js"
cp template.md "$DIR/README.md"
cp fork.png "$DIR/fork.png"
cp -r static "$DIR/static"

# replacing stuff
sed -i '' "s/VAR_NAME/$NAME/g" "$DIR/index.html"
sed -i '' "s/VAR_SUMMARY/$SUMMARY/g" "$DIR/index.html"
sed -i '' "s/VAR_LINK/https:\/\/uoftweb\.github\.io\/$NAME\//g" "$DIR/README.md"
sed -i '' "s/VAR_NAME/$NAME/g" "$DIR/README.md"

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