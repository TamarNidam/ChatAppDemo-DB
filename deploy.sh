#!/bin/bash

#get the vakues from the user
echo "enter values to create a tag: "
read tag name_tag

# check the variable from the user
if [ -n "$tag" ] && [ -n "$name_tag" ]; then
    echo "hello"
    # create a git tag
    git tag -a ${tag} -m ${name_tag}
    git push --tags

    # build the image
    docker build -t chat_app_image .

    # create docker tag
    docker image tag chat_app_image chat_app_image:${tag}

    # run the image
    docker run -d -p 5000:5000 chat_app_image 
else
    echo "i need two argoment, please try again"
fi