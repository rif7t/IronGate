![CI](https://img.shields.io/badge/ci-passing-brightgreen)
![License](https://img.shields.io/badge/license-MIT-informational)
![Stack](https://img.shields.io/badge/stack-Python%20|%20Go%20|%20Rust%20|%20Kubernetes%20|%20Terraform-blue)

🏰 IronGate

IronGate is a lightweight prototype of a secure software factory — built to explore real-world DevSecOps automation with Go, Docker, and GitHub Actions.

It focuses on end-to-end visibility and CI/CD integrity while remaining simple enough to extend.

🚀 Features
Area	Description
Build Integrity	Every build produces a Software Bill of Materials (SBOM) using Syft.
Static Security Scans (SAST)	Source code is scanned with Bandit and Gosec to catch insecure code early. (Planned integration)
Dynamic Security Scans (DAST)	OWASP ZAP is integrated into CI/CD to test running containers.
Policy as Code	Uses Open Policy Agent (OPA) and Conftest for configuration validation (Terraform, Docker, Kubernetes).
Container Security	Images are signed and verified with Cosign for supply-chain integrity.
CI/CD	Fully automated pipeline with Docker builds, signing, and security gates.
Go Application	Minimal Go web server to serve as the test subject for security automation.
🧩 Architecture Overview
IronGate/
├── .github/
│   └── workflows/
│       ├── build.yml           # CI/CD pipeline (build, test, scan)
│       ├── zap_scan.yml        # DAST pipeline with OWASP ZAP
│
├── apps/
│   └── go_server/              # Sample Go web server
│       ├── main.go
│       ├── go.mod
│       └── Dockerfile
│
├── policy/
│   └── docker.rego             # Example OPA/Conftest policy
│
├── reports/                    # Generated scan reports (ZAP, Syft, etc.)
│
└── README.md

🧪 How It Works

Builds & SBOM:
Each commit triggers a Docker build that also generates an SBOM via Syft.

Policy Checks:
Before deployment, OPA/Conftest evaluates Dockerfiles and Terraform configs for compliance.

Security Scans:
ZAP runs against the running container (localhost:8080), producing an HTML report.

Artifact Signing:
Images are signed with Cosign (currently placeholder stage; full verification planned).

🧠 Roadmap

IronGate is meant to grow into a modular research platform for secure CI/CD.

Planned Feature	Purpose
🦀 Rust Log Agent	Centralized, signed telemetry ingestion
🔐 Vault-backed Ephemeral Secrets	Secure short-lived credentials for builds
🧰 Incident Runbooks & Chaos Tests	Resilience and emergency response simulations
⚙️ Go Kubernetes Validating Webhook	Prevent insecure pods from being deployed
💡 Philosophy

IronGate is not a “product.”
It’s a learning sandbox — a testbed for applying DevSecOps concepts that usually live only in theory or enterprise documentation.

Its goal:
turn security controls into living, automated systems you can observe, break, and improve.

🏗️ Running Locally
# Build and run the Go web server
docker build -t irongate-app ./apps/go_server
docker run -p 8080:8080 irongate-app


To simulate the full pipeline:

Fork the repo

Push a change

Check the Actions tab for SBOM, ZAP, and policy results

📚 Monorepo Layout

IronGate follows a simple monorepo approach for experimentation —
one codebase hosting app, infra, and policy layers side-by-side.
