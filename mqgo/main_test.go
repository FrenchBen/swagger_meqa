package main

import (
	"os"
	"path/filepath"
	"testing"

	"github.com/meqaio/swagger_meqa/mqutil"
)

func TestMqgo(t *testing.T) {
	wd, _ := os.Getwd()
	// Use pre-generated data to confirm working
	meqaPath := filepath.Join(wd, "../testdata")
	swaggerPath := filepath.Join(meqaPath, "petstore_meqa.yaml")
	planPath := filepath.Join(meqaPath, "object.yaml")
	resultPath := filepath.Join(meqaPath, "result.yaml")
	testToRun := "all"
	username := ""
	password := ""
	apitoken := ""
	verbose := false

	mqutil.Logger = mqutil.NewFileLogger(filepath.Join(meqaPath, "mqgo.log"))
	runMeqa(&meqaPath, &swaggerPath, &planPath, &resultPath, &testToRun, &username, &password, &apitoken, &verbose)
}

func TestMain(m *testing.M) {
	os.Exit(m.Run())
}
