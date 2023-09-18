# Use a mutli-stage build to help reduce the final binary size
# and attack surface (less number of packages = less attack
# surface).

# Stage: Builder
FROM golang:1.21.1-alpine3.18 as builder

# Go to /app.
WORKDIR /app

# Copy the go.mod and go.sum files first as we can then
# cache the dependency installation layer if those don't
# change for faster builds.
COPY go.mod go.sum ./

# Download the dependencies.
# Use -x for verbose output. Helps in debugging on internal networks
# where we might have a bad GOPROXY.
RUN go mod download -x

# Copy the app source code.
COPY . .

# Build! We'll use the current git commit SHA as the default
# version. Can be switched to a tag.
RUN VERSION=$() make build
