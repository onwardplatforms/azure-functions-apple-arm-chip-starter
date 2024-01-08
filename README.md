# Azure Functions Development Setup on Mac Apple Silicon

This guide provides detailed instructions for setting up a development environment for Azure Functions on Apple silicon using Docker. The example uses Python and includes a sample "Hello World" endpoint, but the setup can be adapted for other programming languages.

## Prerequisites

- A Mac with M2 chip.
- Internet connection for downloading software.
- Homebrew package manager is already installed.

If you don't have homebrew, you can find instructions on how to install it [here](https://brew.sh/).

## Installation Steps

Follow these steps to prepare your environment for running Azure Functions on an Apple silicon Macbook. Skip any steps if the software is already installed.

1.  Install Rosetta 2

    Essential for running x86_64 applications on Apple silicon.

    ```shell
    softwareupdate --install-rosetta
    ```

2.  Install Azure Function Core Tools

    For local development and testing of Azure Functions.

    ```shell
    brew tap azure/functions
    brew install azure-functions-core-tools@4
    ```

3.  Install Docker

    To containerize the Azure Functions app.

    ```shell
    brew install --cask docker
    ```

    After installation:

    - Open Docker Desktop.
    - Navigate to Preferences > Experimental Features.
    - Enable Use Rosetta for x86/amd64 emulation on Apple Silicon.

4.  Clone the Repository

    Get the sample Azure Functions application.

    ```shell
    git clone https://github.com/onwardplatforms/azure-functions-apple-arm-chip-starter.git
    ```

5.  Run the Application Using Docker Compose

    Navigate to the project directory and start the services.

    ```shell
    docker-compose up -d --build --no-cache
    ```

## Application Structure

- The root directory contains the Docker and Nginx configuration files.
- The `hello`` folder contains the Azure Function:
  - `__init__.py`: The Python file with the "Hello World" Azure Function.
  - `function.json`: Configuration for the function, specifying the trigger and bindings.

## Running the Application

1. Start the Application: Run `docker-compose up` to initiate the Azure Functions and Nginx containers. If you changed your api code, be sure to add the flags `--build` and `--no-cache`. If you wnat to run the Docker container in the background using "detached mode", also provide the `-d` flag.
2. Verify Containers: Confirm the running containers using `docker ps`. You should see both Nginx and Azure Functions.

## Test the Function

To trigger the HTTP function running in the container, run `http://localhost/hello`. Use the optional query parameter `name` to personalize the greeting.`

## Customization for Other Languages

While this example uses Python, you can easily modify the Dockerfile and Azure Functions configuration to support other programming languages. The containerization aspect remains consistent across different languages.

## Nginx for Local CORS Configuration

We use Nginx as a reverse proxy to set up CORS settings for local development. This setup is crucial as direct Azure Functions in Docker might have limitations in configuring CORS.

## Shutting Down

To stop and remove the containers:

```shell
docker-compose down
```

## Troubleshooting

### Docker Not Running

`Cannot connect to the Docker daemon at unix:///Users/justinoconnor/.docker/run/docker.sock. Is the docker daemon running?`

To resolve this, open your app tray and start docker.

### Port Conflict

`Bind for 0.0.0.0:8080 failed: port is already allocated`

## Summary

After completing these steps, you will have a development environment for Azure Functions running on your Mac running Apple silicon, with the application containerized using Docker. This setup includes an Nginx container and an Azure Functions container, which can be verified using docker ps. The environment is flexible and can be adapted for various programming languages while maintaining the core containerized structure.
