#!/bin/sh

set -e

binpath=$(go env GOPATH)/bin
govvv=$binpath/govvv

$govvv build -print
$govvv build

$govvv install -print
$govvv install

VERSION=$($binpath/apisprout --version | cut -d ' ' -f3)

GOOS=darwin GOARCH=amd64 $govvv build
tar -cJf apisprout-$VERSION-mac.tar.xz apisprout

GOOS=linux GOARCH=amd64 $govvv build
tar -cJf apisprout-$VERSION-linux.tar.xz apisprout

GOOS=windows GOARCH=amd64 $govvv build
zip -r apisprout-$VERSION-win-$GOARCH.zip apisprout.exe

# rm -f apisprout apisprout.exe
