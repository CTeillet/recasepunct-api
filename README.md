Certainly! Here is the `README.md` file for your project written in Markdown without the initial code block:

# Recasepunc Docker API

This project provides a REST API based on Flask to use **recasepunc**, a tool that corrects letter casing and punctuation in text. The API is hosted in a Docker container, and the language model used by **recasepunc** can be easily customized.

## Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Building the Docker Image](#building-the-docker-image)
- [Usage](#usage)
- [Model Customization](#model-customization)
- [Request Examples](#request-examples)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

Before you begin, make sure you have the following installed:

- [Docker](https://www.docker.com/get-started): To build and run Docker containers.
- [Git](https://git-scm.com/): To clone the repository.

## Installation

Clone the GitHub repository for the project:

```bash
git clone https://github.com/your-username/recasepunc-docker-api.git
cd recasepunc-docker-api
```

## Building the Docker Image

To build the Docker image with the default model (`fr.24000`), use the following command:

```bash
docker build -t recasepunc-api .
```

To build the Docker image with a different model, use the build arguments (`--build-arg`):

```bash
docker build --build-arg MODEL_URL=https://github.com/benob/recasepunc/releases/download/0.4/another_model --build-arg MODEL_NAME=another_model -t recasepunc-api-custom .
```

## Usage

To run the Docker container with the Flask API:

```bash
docker run -d -p 5000:5000 recasepunc-api
```

The API will be available at: `http://localhost:5000`.

## Model Customization

The `Dockerfile` is configured to allow customization of the model used by **recasepunc**. You can specify the model URL and model filename when building the Docker image using build arguments:

```bash
docker build --build-arg MODEL_URL=<MODEL_URL> --build-arg MODEL_NAME=<MODEL_NAME> -t recasepunc-api-custom .
```

For example, to download and use a different model, replace `<MODEL_URL>` with your model's URL and `<MODEL_NAME>` with the model filename.

## Request Examples

You can use `curl` to send POST requests to the API and receive corrected text responses. Here's an example request:

```bash
curl -X POST -H "Content-Type: application/json" -d '{"text": "your unformatted text here."}' http://localhost:5000/recasepunc
```

Expected response:

```json
{
  "formatted_text": "Your unformatted text here."
}
```

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a branch for your feature (`git checkout -b new-feature`).
3. Commit your changes (`git commit -m 'Add a new feature'`).
4. Push your branch (`git push origin new-feature`).
5. Open a Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.