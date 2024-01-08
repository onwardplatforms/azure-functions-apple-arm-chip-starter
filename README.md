# Azure Functions Development Setup on Mac Apple Silicon

This guide provides detailed instructions for setting up a development environment for Azure Functions on Apple silicon using Docker. The example uses Python and includes a sample "Hello World" endpoint, but the setup can be adapted for other programming languages.

We use Nginx as a reverse proxy to set up CORS settings for local development. This is primarily due to current limitations with running Azure Functions on Apple silicon and no good way to set CORS in the Dockerfile to allow local development with other applications (for example, your apps front-end).

## Application Structure

- The root directory contains the Docker and Nginx configuration files.
- The `hello-world` folder contains the Azure Function:
  - `__init__.py`: The Python file with the "Hello World" Azure Function.
  - `function.json`: Configuration for the function, specifying the trigger and bindings.

## Prerequisites

- A Mac with M2 chip.
- Internet connection for downloading software.
- Homebrew package manager is already installed.

If you don't have homebrew, you can find instructions on how to install it [here](https://brew.sh/).

## Install Dependencies

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

## Download the Code

Download this sample Azure Functions application that takes advantage of Docker and Nginx for local development.

```shell
git clone https://github.com/onwardplatforms/azure-functions-apple-arm-chip-starter.git
```

## Build and Run the Application

1.  Build the App

    ```shell
    docker-compose --build --no-cache
    ```

2.  Run the App

    ```shell
    docker-compose up -d
    ```

    If you do not wish to run the application in "detached mode", simply remove the `-d` flag.

3.  Verify the Containers are Running

    ```shell
    docker ps
    ```

    You should see both Nginx and Azure Functions.

## Test the Function

To trigger the HTTP function running in the container, run `http://localhost/hello`. Use the optional query parameter `name` to personalize the greeting.`

## Start Developing

Now that you have Azure Functions running from your container, you can start to develop new functions (endpoints) for your app.

Remember, if you change function code, you will need to re-run `docker-compose --build --no-cache` to ensure your changes are reflected.

To learn more about developing Azure Functions with Python, see the official [Microsoft Documentation](https://learn.microsoft.com/en-us/azure/azure-functions/create-first-function-vs-code-python?pivots=python-mode-decorators). If you decide to go with another language, you can go to the same link, but pick another language in the navigation tree under "Quickstarts".

## Shutting Down

To stop and remove the containers:

```shell
docker-compose down
```

## Summary

After completing these steps, you will have a development environment for Azure Functions running on your Mac running Apple silicon, with the application containerized using Docker. This setup includes an Nginx container and an Azure Functions container, which can be verified using docker ps. The environment is flexible and can be adapted for various programming languages while maintaining the core containerized structure.
