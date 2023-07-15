# AWS Slack Bot

Lambda functions to start and stop EC2 instances that you can plug into you chat bots.

To build and run it locally:

```sh
make
sam local invoke StopFunction --event events/event.json
```

Pushing to an existing 

```sh
sam package --s3-bucket "<bucket name>"
```

Deploying

```sh
sam deploy --guided
```

References:
- [Go project structure for Lambda](https://leonardqmarcq.com/posts/go-project-structure-for-api-gateway-lambda-with-aws-sam)
- [AWS Stop Instances in Go](https://github.com/awsdocs/aws-doc-sdk-examples/blob/main/gov2/ec2/common/StopInstancesv2.go)
- [Logging in Go](https://www.honeybadger.io/blog/golang-logging/)
