# Fast build Django on Linux

## Description

You can have one or more reason's to not to use Docker. I had one so I've created script to fast build Flask app on Debian like OS.
Flask works on Nginx with Gunicorn and as systemd service.

## How to use

1. Download script on Your machine:

```
wget https://github.com/DeviC3/flask-fast-deploy/blob/main/flask-deploy.sh
```

or

```
curl https://github.com/DeviC3/flask-fast-deploy/blob/main/flask-deploy.sh -o flask-deploy.sh
```

2. Customize variables:

- **home_dir** - Your home dir location
- **website** - IP or FQDN domain name
- **app_name** - name of Your systemd service

3. Use it ```bash flask-deploy.sh```
