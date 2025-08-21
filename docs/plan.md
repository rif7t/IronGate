# IronGate — Build Plan (AM/PM)
IronGate — 6-Week Build Plan


Week 1 — Foundations + SBOM / Scans / Policies

Day 1

Morning: Create repo, set up Go hello-api service, add minimal Dockerfile.

Afternoon: Add GitHub Actions workflow to build & push container image.

Day 2

Morning: Install/test Syft locally, generate SBOM for container.

Afternoon: Write scan_sbom.py, add CI step to upload SBOM artifact.

Day 3

Morning: Add Bandit (Python), Gosec (Go), Clippy + Cargo Audit (Rust).

Afternoon: Write run_sast.py wrapper, integrate SAST checks into CI.

Day 4

Morning: Run OWASP ZAP baseline scan against container locally.

Afternoon: Write run_dast.py, integrate ZAP into CI pipeline.

Day 5

Morning: Install Conftest, write Rego policy to block USER root in Dockerfiles.

Afternoon: Add CI gate to fail on policy violations.

Day 6

Morning: Refactor CI into clear stages (build, sbom, sast, dast, policy).

Afternoon: Run negative tests (bad Dockerfile, vulnerable lib) to validate gates.

Day 7

Morning: Write README + architecture diagram of pipeline.

Afternoon: Record short demo video/GIF of pipeline blocking insecure build.

Week 2 — Supply Chain Security + IaC
Day 8

Morning: Set up Cosign for keyless signing (OIDC).

Afternoon: Add cosign verify step in CI before deploy.

Day 9

Morning: Create minimal Terraform infra (VPC, bucket, VM).

Afternoon: Add CI workflow for Terraform init/validate/plan.

Day 10

Morning: Write Rego rules for Terraform (block public S3, open SG).

Afternoon: Add Conftest check for Terraform files + plan JSON.

Day 11

Morning: Integrate Checkov for IaC scanning.

Afternoon: Configure severity thresholds (fail on High/Critical).

Day 12

Morning: Wire end-to-end: build → sign → Terraform plan → policy gates.

Afternoon: Enforce deploy only if signature + policies pass.

Day 13

Morning: Write trust model doc (SBOM + signing + IaC policies).

Afternoon: Capture screenshots of pass vs fail runs.

Day 14

Morning: Refactor CI configs, enable caching for faster builds.

Afternoon: Light review + prep backlog for secrets & Kubernetes week.

Week 3 — Secrets + Kubernetes
Day 15

Morning: Deploy Vault in dev mode, enable KV v2.

Afternoon: Manually fetch/store secrets via Vault CLI.

Day 16

Morning: Write rotate_secrets.py to rotate demo secrets.

Afternoon: Add CI job to rotate secrets nightly.

Day 17

Morning: Integrate Vault with CI using OIDC/JWT auth.

Afternoon: Inject short-lived secrets into deploy jobs.

Day 18

Morning: Set up kind/minikube cluster locally.

Afternoon: Deploy signed container with secrets injected from Vault.

Day 19

Morning: Write Conftest rule to block hardcoded secrets in manifests.

Afternoon: Add CI policy gate for manifests.

Day 20

Morning: Run positive + negative tests (hardcoded vs dynamic secrets).

Afternoon: Write documentation + demo of secret workflow.

Day 21

Morning: Clean up secret-related CI steps, redact logs.

Afternoon: Weekly summary + prep webhook backlog.

Week 4 — Admission Controller (Go)
Day 22

Morning: Scaffold Go validating admission webhook.

Afternoon: Deploy empty webhook to cluster.

Day 23

Morning: Add TLS certs + CABundle for webhook.

Afternoon: Test webhook is being called by API server.

Day 24

Morning: Add rule: block privileged pods.

Afternoon: Apply bad manifest, verify rejection.

Day 25

Morning: Add rule: enforce non-root & drop capabilities.

Afternoon: Write unit tests for rule logic.

Day 26

Morning: Add metrics endpoint + health checks.

Afternoon: Build Grafana dashboard for webhook metrics.

Day 27

Morning: Add CI job for webhook build + unit tests.

Afternoon: Integration test in KinD (good vs bad pods).

Day 28

Morning: Write webhook documentation.

Afternoon: Record demo video of webhook blocking insecure pods.

Week 5 — Rust Agent + Observability
Day 29

Morning: Create Rust project (Tokio, Serde, Reqwest).

Afternoon: Prototype log tailer → JSON output.

Day 30

Morning: Batch logs + implement retry/backoff.

Afternoon: Build local API endpoint to receive logs.

Day 31

Morning: Add field redaction/deny filters.

Afternoon: Add config via env vars / file.

Day 32

Morning: Implement TLS pinning for server connection.

Afternoon: Add Cosign-signed config bundle verification.

Day 33

Morning: Add SQLite/ClickHouse storage sink.

Afternoon: Build FastAPI/CLI tool to view stored logs.

Day 34

Morning: Expose Prometheus metrics (logs processed, errors).

Afternoon: Add Grafana dashboards for log agent.

Day 35

Morning: Write docs: agent architecture + security choices.

Afternoon: Record demo of agent streaming logs to dashboard.

Week 6 — IR, Chaos Testing & Final Polish
Day 36

Morning: Draw data flow diagram (DFD) + STRIDE threat model.

Afternoon: Map threats to mitigations (OPA rules, Cosign, Vault, Webhook).

Day 37

Morning: Implement break-glass deploy flow with TTL token.

Afternoon: Log + alert on break-glass usage.

Day 38

Morning: Chaos test: revoke signer identity.

Afternoon: Confirm deploys fail-safe with clear errors.

Day 39

Morning: Chaos test: corrupt SBOM/attestation.

Afternoon: Improve error messaging for failed integrity checks.

Day 40

Morning: Write incident response runbooks (CVE spike, failed signature, leaked secret).

Afternoon: Run tabletop drills to validate runbooks.

Day 41

Morning: Draft STAR interview stories + resume bullets.

Afternoon: Polish README, add quickstart + CI badges.

Day 42

Morning: Record final demo (commit → build → sign → policy → deploy → logs).

Afternoon: Publish demo video + GitBook pages, write LinkedIn update.
