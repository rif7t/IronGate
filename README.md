# IronGate
An end-to-end DevSecOps lab that signs, builds, enforces policy, and ships telemetry, built with Python, Go, and Rust.


![CI](https://img.shields.io/badge/ci-passing-brightgreen)
![License](https://img.shields.io/badge/license-MIT-informational)
![Stack](https://img.shields.io/badge/stack-Python%20|%20Go%20|%20Rust%20|%20Kubernetes%20|%20Terraform-blue)

## What is IronGate?
- IronGate is a miniature secure software factory designed to demonstrate modern DevSecOps practices.

- Currently implemented

- SBOM generation for every build (Syft)

- Static and dynamic analysis gates (Bandit, OWASP ZAP)

- Policy as Code enforcement (OPA/Conftest) for Docker, Kubernetes, and Terraform

- Container signing and verification (Cosign)

- Planned extensions

- Go-based Kubernetes Validating Webhook for blocking insecure pods

- Rust Log Agent with TLS pinning and signed configurations

- Vault-backed ephemeral secrets in CI/CD

- Incident response runbooks, chaos tests, and a break-glass recovery flow
## 📂 Monorepo Layout
