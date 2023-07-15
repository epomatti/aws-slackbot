package utils

import (
	"context"
	"log"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
)

func Error(body string, statusCode int, err error) (events.APIGatewayProxyResponse, error) {
	log.Println(err)
	return events.APIGatewayProxyResponse{
		Body:       body,
		StatusCode: statusCode,
	}, err
}

func Ok(body string) (events.APIGatewayProxyResponse, error) {
	return events.APIGatewayProxyResponse{
		Body:       body,
		StatusCode: 200,
	}, nil
}

func NewConfig() (aws.Config, error) {
	return config.LoadDefaultConfig(context.TODO())
}
