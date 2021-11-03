package main

import (
	"os"
	"path/filepath"
	"testing"

	"github.com/meqaio/swagger_meqa/mqutil"
)

func TestMqgen(t *testing.T) {
	mqutil.Logger = mqutil.NewStdLogger()
	wd, _ := os.Getwd()
	testDataPath := filepath.Join(wd, "../testdata")
	meqaPath := t.TempDir()
	swaggerPath := filepath.Join(testDataPath, "petstore_meqa.yaml")
	algorithm := "all"
	verbose := false
	whitelistPath := ""
	run(&meqaPath, &swaggerPath, &algorithm, &verbose, &whitelistPath)
}

func TestMain(m *testing.M) {
	os.Exit(m.Run())
}
