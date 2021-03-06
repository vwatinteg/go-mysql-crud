package handler

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/golang/mock/gomock"
	"github.com/stretchr/testify/require"

	"github.com/vwatinteg/go-mysql-crud/driver"
	models "github.com/vwatinteg/go-mysql-crud/models"
	"github.com/vwatinteg/go-mysql-crud/repository/mock"
)

func Test_Fetch(t *testing.T) {

	mockCtl := gomock.NewController(t)
	defer mockCtl.Finish()
	mockPostRepo := mock.NewMockPostRepo(mockCtl)

	mockPostRepo.EXPECT().Fetch(gomock.Any(), int64(5)).Return([]*models.Post{}, nil)

	response := httptest.NewRecorder()

	connection, err := getFakeDBConnection()
	require.NoError(t, err)
	require.NotEmpty(t, connection)

	pHandler := NewPostHandler(connection)
	require.NotEmpty(t, pHandler)

	pHandler.SetPostHandler(mockPostRepo)

	request, err := http.NewRequest("GET", "https://localhost/posts", nil)
	require.NoError(t, err)

	pHandler.Fetch(response, request)

	require.Equal(t, 200, response.Result().StatusCode)
	require.NotEmpty(t, request)
}

func Test_FetchWithPayload(t *testing.T) {

	mockCtl := gomock.NewController(t)
	defer mockCtl.Finish()
	mockPostRepo := mock.NewMockPostRepo(mockCtl)

	mockPostRepo.EXPECT().Fetch(gomock.Any(), int64(5)).Return([]*models.Post{
		{ID: int64(1), Title: "title-1", Content: "content-1"},
	}, nil)

	response := httptest.NewRecorder()

	connection, err := getFakeDBConnection()
	require.NoError(t, err)
	require.NotEmpty(t, connection)

	pHandler := NewPostHandler(connection)
	require.NotEmpty(t, pHandler)

	pHandler.SetPostHandler(mockPostRepo)

	request, err := http.NewRequest("GET", "https://localhost/posts/1", nil)
	require.NoError(t, err)

	pHandler.Fetch(response, request)

	require.Equal(t, 200, response.Result().StatusCode)
	require.NotEmpty(t, request)
}

func Test_CreateWithEmptyDB(t *testing.T) {

	mockCtl := gomock.NewController(t)
	defer mockCtl.Finish()
	mockPostRepo := mock.NewMockPostRepo(mockCtl)

	payload := &models.Post{
		ID:      1,
		Title:   "title-1",
		Content: "content-1",
	}

	mockPostRepo.EXPECT().Create(gomock.Any(), payload).Return(int64(1), nil)

	response := httptest.NewRecorder()

	connection, err := getFakeDBConnection()
	require.NoError(t, err)
	require.NotEmpty(t, connection)

	pHandler := NewPostHandler(connection)
	require.NotEmpty(t, pHandler)

	pHandler.SetPostHandler(mockPostRepo)
	jsonBytes, err := json.Marshal(payload)
	require.NoError(t, err)

	request, err := http.NewRequest("POST", "https://localhost/posts", strings.NewReader(string(jsonBytes)))
	require.NoError(t, err)

	pHandler.Create(response, request)

	require.Equal(t, 201, response.Result().StatusCode)
	require.NotEmpty(t, request)
}

func getFakeDBConnection() (*driver.DB, error) {
	return driver.ConnectSQL("test", "3306", "root", "dbPass", "dbName")
}
