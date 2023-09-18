# Use a mutli-stage build to help reduce the final binary size
# and attack surface (less number of packages = less attack
# surface).

# Stage: Build
FROM golang:1.21.1-alpine3.18 as builder

# Go to /app.
WORKDIR /app

# Install make and git before anything else.
RUN apk update && apk add make git

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
# version. Can be switched to a tag. We will also build with
# CGO disabled unless we need it. Allows us to use scratch as
# the final image. Check the Makefile for build flags and such.
RUN VERSION=$(git rev-parse --verify HEAD) make build

# Stage: Final image

# We'll use a scratch image. That is the one which has no
# operating system as that is enough for this one.
FROM scratch

# Switch to a non-root UID.
USER 1000

# Copy the application.
COPY --from=builder /app/demo.bin /app

# Set it as the entrypoint. Ideally, we should set the listen
# address and the exposed port in the docker-compose.yml, or
# the kubernetes manifests.
ENTRYPOINT ["/app"]

# We'll end up with a nice thin docker image.
