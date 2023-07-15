package main

import (
	"context"
	"encoding/json"
	"slackbot/utils"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/service/ec2"
)

type Request = events.APIGatewayProxyRequest
type Response = events.APIGatewayProxyResponse

type Body struct {
	InstanceIds []string `json:"instanceIds"`
}

func handler(r Request) (Response, error) {

	cfg, err := utils.NewConfig()
	if err != nil {
		return utils.Error("Failed ot load AWS config", 500, err)
	}

	var body Body
	err = json.Unmarshal([]byte(r.Body), &body)
	if err != nil {
		return utils.Error("Failed to process body", 400, err)
	}

	client := ec2.NewFromConfig(cfg)
	input := &ec2.StopInstancesInput{
		InstanceIds: body.InstanceIds,
	}
	_, err = client.StopInstances(context.TODO(), input)
	if err != nil {
		return utils.Error("Error stopping instances", 500, err)
	}

	return utils.Ok("Instance stopping")
}

func main() {
	lambda.Start(handler)
}
