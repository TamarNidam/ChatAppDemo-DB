# #!/bin/bash
# # To remove only the container that build on the image "chat-app"
# # docker rm $(docker ps -a -q --filter="ancestor=chat-app")

# # To remove all the images "chat-app"
# docker rmi $(docker images -q --filter="name=chat-app")

# # To build the image "chat_app_image"
# docker build -t chat-app .

# # To run the image
# docker run -p 5000:5000 chat-app

# #!/bin/bash
# To remove only the container that build on the image "chat_app_image"
docker rm -f $(docker ps -a -q --filter="ancestor=chat_app_image")
# To remove all the images "chat_app_image"
docker rmi $(docker images -q --filter="dangling=true")
# To build the image "chat_app_image"
docker build -t chat_app_image .
# To run the image
docker run -d -p 5000:5000 chat_app_image