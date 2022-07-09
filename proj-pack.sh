echo "please enter project name"
read NAME

echo "$0: packaging the project"

cd ~/IdeaProjects/${NAME}

mvn package
