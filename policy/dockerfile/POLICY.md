# Dockerfile Security and Best Practices Policy

**Policy ID:** DOCKER-DF1  
**Category:** Security / Best Practice  
**Status:** Active  
**Last Updated:** 2025-11-11  


## 1. Purpose / Objective

This policy ensures that all Docker images built in the IronGate project are secure, reproducible, and follow container best practices. It prevents security risks such as privilege escalation, secret leakage, and supply chain vulnerabilities.


## 2. Scope

Applies to all Dockerfiles in the IronGate repository, including multi-stage builds and base images. Covers instructions such as `FROM`, `RUN`, `COPY`, `USER`, and environment variable definitions.

## 3. Policy Statement

1. **Trusted Base Images:** Only use official or organization-approved base images.  
2. **No `latest` Tag:** Tag base image versions explicitly; do not use `:latest`.  
3. **Non-Root Containers:** Containers must specify a non-root `USER`.  
4. **No Secrets in Dockerfile:** Do not hardcode passwords, tokens, or API keys.  
5. **Use COPY Instead of ADD:** Only use ADD if its URL/extraction functionality is required.  
6. **Avoid Sudo & SSH:** Do not install or run SSH or use `sudo` inside containers.  
7. **Clean Package Caches:** Remove package manager caches after installing packages.  
8. **Avoid `curl | bash` Install Patterns:** Only install verified packages.  
9. **Use Multi-Stage Builds:** Build artifacts should not include unnecessary intermediate layers.

## 4. Rationale

- Running containers as root increases risk of privilege escalation.  
- Pinning image versions ensures reproducible, auditable builds.  
- Trusted base images prevent malicious code from entering the supply chain.  
- Secrets in Dockerfiles risk leakage to repositories or container registries.  
- Multi-stage builds and cache cleanup reduce image size and attack surface.

## 5. Enforcement / Implementation Notes

- Use **Conftest with Rego rules** to automatically detect violations:  
  - Deny if `USER` is root or missing  
  - Deny if `FROM` uses `latest`  
  - Deny if `CMD` uses `ADD`
  - Warn if package caches are not cleaned  
  - Deny if `RUN` commands include `sudo` or SSH installs  
  - Deny if secrets are detected in `ENV` instructions  

- Integrate Conftest checks into the CI/CD pipeline: Dockerfiles must pass policy scans before merge.

## 6. Exceptions / Notes

- Trusted build images may require temporary root access during the build stage but must switch to a non-root user for the final image.  
- Internal base images approved by the security team are allowed even if they differ from official Docker Hub images.

## 7. References / Related Standards

- [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)  
- [CIS Docker Benchmark](https://www.cisecurity.org/benchmark/docker/)  
- IronGate Policy-as-Code Guidelines (internal)
