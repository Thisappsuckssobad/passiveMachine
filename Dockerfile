# Use the official Golang image as the base for building the application
FROM golang:1.20-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum files for dependency installation
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the entire application source
COPY . .

# Build the Go binary
RUN go build -o myapp .

# Use a minimal base image for the final container
FROM alpine:3.17

# Copy the compiled binary from the builder stage
COPY --from=builder /app/myapp /bin/myapp

# Expose the application's port (if applicable)
EXPOSE 8080

# Run the application
CMD ["myapp"]
