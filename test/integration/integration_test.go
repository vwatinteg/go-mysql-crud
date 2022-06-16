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

	if len(svr.port) == 0 {
		svr.port = "8005"
	}

	return svr
}

func Test_Get(t *testing.T) {
	server := getServerInfo(t)
	request, err := http.NewRequest(http.MethodGet, fmt.Sprintf("%s://%s:%s/%s", "http", server.host, server.port, "posts"), nil)
	require.NoError(t, err)

	response, err := http.DefaultClient.Do(request)
	require.NoError(t, err)
	require.NotEmpty(t, response)
	require.Equal(t, 200, response.StatusCode)
}
