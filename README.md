# es-index-cleaner

Elasticsearch index cleaner docker image

## Usage

```yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: index-cleaner
spec:
  schedule: "0 0 * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: index-cleaner
            env:
              - name: ELASTIC_PASSWORD
                valueFrom:
                  secretKeyRef:
                    key: elastic
                    name: elastic-es-elastic-user         
            image: makeoptim/es-index-cleaner
            command: ["/bin/sh","-c"]
            args: ["curl --insecure -u elastic:$ELASTIC_PASSWORD -XDELETE https://elastic-es-http:9200/logstash-*`date -d'7 days ago' +'%Y.%m.%d'`"]
          restartPolicy: Never
      backoffLimit: 2
```

## References

- <https://makeoptim.com/kubernetes/logging-high-availability>
- <https://blog.chesterwood.io/2019/06/how-to-delete-old-elasticsearch-logs.html>
- <https://www.cyberciti.biz/faq/how-to-curl-ignore-ssl-certificate-warnings-command-option/>