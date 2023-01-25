/*
Copyright (c) 2021-present cqisense. All Rights Reserved.
See LICENSE for license information.
*/

package init

import (
	"github.com/GoogleCloudPlatform/functions-framework-go/functions"
	"github.com/iknite/gcp-cf-golang-logging/pkg/cmd"
)

func init() { //nolint:gochecknoinits
	functions.CloudEvent("logging-test", cmd.CFInit)
}
