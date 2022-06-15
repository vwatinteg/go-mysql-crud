package main

import (
	"os"
	"testing"
)

func init() {}

func TestMain(t *testing.T) {

	if len(os.Getenv("TEST_COVER")) > 0 {
		return
	}

	main()
}
