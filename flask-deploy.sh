#!/bin/bash

#############################################################
#   Author: Krzysztof Kuberski                              #
#   Contact: xkrzysztof.kuberskix@gmail.com                 #
#   Github: https://github.com/DeviC3/django-auto-deploy    #
#############################################################

home_dir=/var/www/app
website=$(hostname --ip-address)
app_name=myapp

function baseConfig(){

systemctl stop apache2
systemctl disable apache2
apt-get update
apt-get install python3 python3-pip virtualenv python3-flask gunicorn nginx -y
mkdir -p $home_dir

cd $home_dir || exit

chown -R www-data:www-data $home_dir
touch main.py wsgi.py
}

function createFiles(){

cat << EOF > $home_dir/main.py
from flask import Flask
 
app = Flask(__name__)
@app.route("/")
def home():
    return "<h1>Hello from Nginx and Gunicorn</h1>"
EOF


cat << EOF > $home_dir/wsgi.py
from main import app
 
if __name__ == "__main__":
    app.run(debug=True)

EOF


cat << EOF > /etc/nginx/sites-available/$app_name.conf
server {
        listen 80;
        server_name $website;
 
        access_log /var/log/nginx/$website.access.log;
        error_log /var/log/nginx/$website.error.log;
 
        location / {
                include proxy_params;
                proxy_pass http://unix:$home_dir/$app_name.sock;
        }
}
EOF


cat << EOF > /etc/systemd/system/$app_name.service
[Unit]
Description=$app_name.service - A Flask application run with Gunicorn.
After=network.target
 
[Service]
User=www-data
Group=www-data
WorkingDirectory=$home_dir
ExecStart=/usr/bin/gunicorn --workers 3 --bind unix:$home_dir/$app_name.sock wsgi:app
 
[Install]
WantedBy=multi-user.target
EOF

ln -s /etc/nginx/sites-available/$app_name.conf /etc/nginx/sites-enabled/

}

function serviceAction(){

systemctl start nginx
systemctl enable nginx
systemctl restart nginx
systemctl daemon-reload
systemctl enable $app_name.service
systemctl start $app_name.service

if [ `systemctl is-active $app_name` == "active" ]; then
echo -e "\nYour Flask app should be available, have fun!"
else
echo -e "Is all services is running?"
command -v gunicorn
command -v nginx
command -v python3
fi

}

baseConfig
createFiles
serviceAction
