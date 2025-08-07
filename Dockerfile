# Minimal Syft container for SBOM generation
# Maintainer: Your Name <>
                                                                                         
CMD ["dir:/scan"]
# Stage 1: Builder using Alpine
FROM alpine:3.20 AS builder

RUN mkdir /out
COPY syft /out/syft

# Stage 2: Minimal Alpine runtime
FROM alpine:3.20

COPY --from=builder /out/syft /bin/syft
RUN chmod +x /bin/syft

WORKDIR /scan

ENTRYPOINT ["/bin/syft"]
CMD ["dir:/scan"]

