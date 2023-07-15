package utils

import (
	"context"
	"log"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
)

type Response = events.APIGatewayProxyResponse

func Error(body string, statusCode int, err error) (Response, error) {
	log.Println(err)
	return Response{
		Body:       body,
		StatusCode: statusCode,
	}, err
}

func Ok(body string, statusCode int) (Response, error) {
	return Response{
		Body:       body,
		StatusCode: statusCode,
	}, nil
}

func NewConfig() (aws.Config, error) {
	return config.LoadDefaultConfig(context.TODO())
}
