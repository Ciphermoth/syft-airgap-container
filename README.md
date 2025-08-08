# syft-airgap-container
This project uses [Syft](https://github.com/anchore/syft), an open-source CLI tool from Anchore for generating Software Bill of Materials (SBOMs).
> ⚠️ This project is not affiliated with Anchore or the official Syft project. It provides a custom container setup for using Syft in air-gapped environments.
>

## 
You can download the latest release from the official GitHub page:
To build the container or run the scan script, you’ll need the Syft binary.

👉 [Syft Releases](https://github.com/anchore/syft/releases)

##

## 🐳 Docker Hub

This container is published on Docker Hub for easy access:
docker pull moth12/syft-container
https://hub.docker.com/r/moth12/syft-container
##
Syft Container SBOM Scanner

Generate and inspect Software Bill of Materials (SBOMs) for your container images using [Syft](https://github.com/anchore/syft). This containerized setup makes it easy to scan images and export SBOMs in multiple formats.

---

## Usage

### Scan a container image and view the SBOM

```bash

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock syft-container alpine:latest Export SBOMs in different formats
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock syft-container alpine:latest -o json > sbom.json
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock syft-container alpine:latest -o cyclonedx-json > sbom-cyclonedx.json
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock syft-container alpine:latest -o spdx-json > sbom-spdx.json

Inspect SBOM contents

View top-level keys

jq 'keys' sbom.json

Explore packages

jq '.artifacts[] | {name, version, type}' sbom.json

Filter by package type

jq '.artifacts[] | select(.type=="apk") | {name, version}' sbom.json

