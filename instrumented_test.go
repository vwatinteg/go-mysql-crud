package main

import (
	"os"
	"testing"

	"github.com/spf13/cast"
)

func init() {}

func TestMain(t *testing.T) {

	if !cast.ToBool(os.Getenv("TEST_COVER")) {
		return
	}

	main()
}
