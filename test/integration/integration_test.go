package integration_test

import (
	"fmt"
	"net/http"
	"os"
	"testing"

	"github.com/stretchr/testify/require"
)

type testServer struct {
	host string
	port string
}

func getServerInfo(t *testing.T) *testServer {
	svr := &testServer{
		host: os.Getenv("SERVER_HOST"),
		port: os.Getenv("SERVER_PORT"),
	}

	if len(svr.host) == 0 {
		svr.host = "localhost"
	}

	return svr
}

func Test_Get(t *testing.T) {
	server := getServerInfo(t)

	url := fmt.Sprintf("http://%s", server.host)
	if len(server.port) > 0 {
		url = fmt.Sprintf("%s:%s", url, server.port)
	}

	url += "/posts"

	request, err := http.NewRequest(http.MethodGet, url, nil)
	require.NoError(t, err)

	response, err := http.DefaultClient.Do(request)
	require.NoError(t, err)
	require.NotEmpty(t, response)
	require.Equal(t, 200, response.StatusCode)
}
