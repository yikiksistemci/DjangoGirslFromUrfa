# Dockerize First Django Blog App

### Dockerfile
```bash
FROM python:3.4

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY . .
CMD ["python","manage.py","migrate"]
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
```

### Run on Docker
```bash
$ docker pull yikiksistemci/django_rancher:v1.0.0
$ docker run --name my-django-app -p 8000:8000 -d yikiksistemci/django_rancher:v1.0.0
```
### Run on Rancker (k8s)
 ```bash
 $ kubectl create -f deployment.yaml 
 $ kubectl get deploy
 $ kubectl create -f service.yaml
 $ kubectl get svc
 $ kubectl create -f ingress.yaml
 $ kubectl get ingress
 ```
:TODO



