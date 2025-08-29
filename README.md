# IronGate
An end-to-end DevSecOps lab that signs, builds, enforces policy, and ships telemetry — built with Python, Go, and Rust.


![CI](https://img.shields.io/badge/ci-passing-brightgreen)
![License](https://img.shields.io/badge/license-MIT-informational)
![Stack](https://img.shields.io/badge/stack-Python%20|%20Go%20|%20Rust%20|%20Kubernetes%20|%20Terraform-blue)

## What is IronGate?
IronGate is a miniature secure software factory:
- **SBOMs** (Syft) for every build
- **SAST/DAST** gates (Bandit, Gosec, Cargo Audit, OWASP ZAP)
- **Policy as Code** (OPA/Conftest) for Docker, Kubernetes, Terraform
- **Cosign** signing + verification (supply chain integrity)
- **Go** **Kubernetes Validating Webhook** (blocks insecure pods)
- **Rust** **Log Agent** (TLS pinning, signed config) → **FastAPI/SQLite** → **Grafana**
- **Vault**-backed **ephemeral secrets** in CI/CD
- **IR runbooks**, **chaos tests**, and a **break-glass** flow

## 📂 Monorepo Layout
