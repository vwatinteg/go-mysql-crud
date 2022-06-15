package repsitory

import (
	"context"

	"github.com/vwatinteg/go-mysql-crud/models"
)

// PostRepo explain...
//go:generate mockgen -source repository.go -destination=mock/mock_postrepo.go -package=mock
type PostRepo interface {
	Fetch(ctx context.Context, num int64) ([]*models.Post, error)
	GetByID(ctx context.Context, id int64) (*models.Post, error)
	Create(ctx context.Context, p *models.Post) (int64, error)
	Update(ctx context.Context, p *models.Post) (*models.Post, error)
	Delete(ctx context.Context, id int64) (bool, error)
}
