#Automates SBOM + vulnerability scanning for all Docker images
#!/bin/bash

OUTPUT_DIR="output"
mkdir -p "$OUTPUT_DIR"

echo "🔍 Listing Docker images..."
IMAGES=$(docker images --format "{{.Repository}}:{{.Tag}}" | sort | uniq)

for IMAGE in $IMAGES; do
    # Skip dangling images
    if [[ "$IMAGE" == "<none>:<none>" ]]; then
        echo "Skipping dangling image: $IMAGE"
        continue
    fi

    # Sanitize filename
    SAFE_NAME=$(echo "$IMAGE" | sed 's|/|_|g' | sed 's|:|_|g')
    SBOM_FILE="$OUTPUT_DIR/${SAFE_NAME}_sbom.json"
    REPORT_FILE="$OUTPUT_DIR/${SAFE_NAME}_vuln.txt"

    echo "Scanning image: $IMAGE"

    # Generate SBOM
    syft "$IMAGE" -o json > "$SBOM_FILE"

    # Scan with Grype
    grype sbom:"$SBOM_FILE" -o table > "$REPORT_FILE"

    echo " Report saved: $REPORT_FILE"
done

echo " All images scanned. Reports are in the '$OUTPUT_DIR' folder."
