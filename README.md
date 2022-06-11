# Fast build Django on Linux

## Description

You can have one or more reason's to not to use Docker. I had one so I've created script to fast build Flask app on Debian like OS.
Flask works on Nginx with Gunicorn and as systemd service.

## How to use

1. Download script on Your machine:

```
wget https://raw.githubusercontent.com/DeviC3/flask-fast-deploy/main/flask-deploy.sh
```
download with executing
```
wget -O - https://raw.githubusercontent.com/DeviC3/flask-fast-deploy/main/flask-deploy.sh | bash
```
or

```
curl https://raw.githubusercontent.com/DeviC3/flask-fast-deploy/main/flask-deploy.sh -o flask-deploy.sh
```
download with executing
```
bash <(curl -s https://raw.githubusercontent.com/DeviC3/flask-fast-deploy/main/flask-deploy.sh)
``
2. Customize variables:

- **home_dir** - Your home dir location
- **website** - IP or FQDN domain name
- **app_name** - name of Your systemd service

3. Use it ```bash flask-deploy.sh```
