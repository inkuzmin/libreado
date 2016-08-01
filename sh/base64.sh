#!/bin/sh

openssl base64 -in <infile> -out <outfile>

openssl base64 < path/to/file.png | tr -d '\n' | pbcopy