# docassemble-os
This is not the endpoint for running docassemble but rather the 'middleware' image used in the final docassemble 
container. See the [docassemble website](https://docassemble.org) for a description of **docassemble** and 
installation instructions.

To get help with using **docassemble**, join the [docassemble Slack group]((https://docassemble.org/docs/support.html).

## Git repos for docassemble
The `jhpyle/docassemble-os` repository contains a Dockerfile for building the base image of the `jhpyle/docassemble` 
Docker image.

- [docassemble-os](https://github.com/jhpyle/docassemble/)
- [docassemble](https://github.com/jhpyle/docassemble/)

## Build notes

- If on an ARM Mac use `docker build --platform linux/amd64 -t docassemble-os .` to build the image.
- Add `--file <Dockerfile Name)` to your `docker build` command if Dockerfile isn't the name of the file.
- This image isn't designed to be run on its own.  It is designed to be the starting point for the Dockerfile for 
  docassemble.  To load this image as a container you'll need to provide a command to run: `docker run --rm -it -p 
  80:80 -p 443:443 docassemble-os /bin/bash`
