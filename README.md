# Nginx Load Balancer

## Decription

This is my pet project I made  to train and brush up on my knowledge about Nginx. I decided to host website I found on the Internet and also used a self-signed certificate for it. Firstly I span up 3 docker containers on which Nginx will send traffic. After that I configured nginx.conf to listen all the traffic on port 8080 and send all the requests on three docker containers using `Round Robin` method (default method). 

### To run this project You have to 

 * Clone the repo into your folder;
 
    `git clone https://github.com/Sniqur/nginx_load_balancer.git`

 * Get into cloned directory;

    `cd nginx_load_balancer` 

 * Copy all the config from cloned **nginx.conf** to your  **nginx.conf** file;

    `sudo cp nginx_load_balancer/nginx.conf /etc/nginx/nginx.conf`

 * Build Docker containers;

    `docker-compose up --build -d`

* Run / Restart Nginx.

    `nginx` or `systemctl start nginx` - to start Nginx

    `nginx -s reload`  or  `systemctl restart nginx` - to restart Nginx


* Type **localhost:8080** in the browser.