# Ghost [![Version](https://img.shields.io/badge/version-5-15171a)](https://github.com/stackblaze-templates/ghost) [![Maintained by StackBlaze](https://img.shields.io/badge/maintained%20by-StackBlaze-blue)](https://stackblaze.com) [![Weekly Updates](https://img.shields.io/badge/updates-weekly-green)](https://github.com/stackblaze-templates/ghost/actions) [![Deploy on StackBlaze](https://img.shields.io/badge/Deploy%20on-StackBlaze-orange)](https://stackblaze.com)

<p align="center"><img src="logo.png" alt="ghost" width="120"></p>

A powerful publishing platform for blogs, newsletters, and membership sites. Ghost is a modern, open-source CMS with built-in email newsletters, memberships, and subscriptions.

> **Credits**: Built on [Ghost](https://ghost.org) by [Ghost Foundation](https://github.com/TryGhost). All trademarks belong to their respective owners.

## Local Development

Copy `.env.example` to `.env` and set strong passwords before starting:

    cp .env.example .env
    # Edit .env and set MYSQL_PASSWORD and MYSQL_ROOT_PASSWORD
    docker compose up

Visit http://localhost:2368 for the site and http://localhost:2368/ghost for admin.

## Deploy on StackBlaze

[![Deploy on StackBlaze](https://img.shields.io/badge/Deploy%20on-StackBlaze-orange)](https://stackblaze.com)

This template includes a `stackblaze.yaml` for one-click deployment on [StackBlaze](https://stackblaze.com). Both options run on **Kubernetes** for reliability and scalability.

<details>
<summary><strong>Standard Deployment</strong> — Single-instance Kubernetes setup for startups and moderate traffic</summary>

<br/>

```mermaid
flowchart LR
    U["Customers"] -->|HTTPS| LB["Edge Network\n+ SSL"]
    LB --> B["Ghost\nNode.js"]
    B --> DB[("MySQL\nManaged DB")]
    B --> S3["Object Storage\nMedia + Assets"]

    style LB fill:#ff9800,stroke:#e65100,color:#fff
    style B fill:#0041ff,stroke:#002db3,color:#fff
    style DB fill:#4caf50,stroke:#2e7d32,color:#fff
    style S3 fill:#2196f3,stroke:#1565c0,color:#fff
```

**What you get:**
- Single Ghost instance on Kubernetes
- Managed MySQL database
- Automatic SSL/TLS via StackBlaze edge network
- Object storage for media and assets
- Automated daily backups
- Zero-downtime deploys

**Best for:** Development, staging, and moderate-traffic production environments.

</details>

<details>
<summary><strong>High Availability Deployment</strong> — Multi-instance Kubernetes setup for business-critical production</summary>

<br/>

```mermaid
flowchart LR
    U["Customers"] -->|HTTPS| CDN["CDN\nStatic Assets"]
    CDN --> LB["Load Balancer\nAuto-scaling"]
    LB --> B1["Ghost #1"]
    LB --> B2["Ghost #2"]
    LB --> B3["Ghost #N"]
    B1 --> R[("Redis\nSessions + Cache")]
    B2 --> R
    B3 --> R
    B1 --> DBP[("MySQL Primary\nRead + Write")]
    B2 --> DBP
    B3 --> DBR[("MySQL Replica\nRead-only")]
    DBP -.->|Replication| DBR
    B1 --> S3["Object Storage\nMedia + Assets"]
    B2 --> S3
    B3 --> S3
    B1 --> Q["Queue Worker\nBackground Jobs"]
    Q --> R
    Q --> DBP

    style CDN fill:#607d8b,stroke:#37474f,color:#fff
    style LB fill:#ff9800,stroke:#e65100,color:#fff
    style B1 fill:#0041ff,stroke:#002db3,color:#fff
    style B2 fill:#0041ff,stroke:#002db3,color:#fff
    style B3 fill:#0041ff,stroke:#002db3,color:#fff
    style R fill:#f44336,stroke:#c62828,color:#fff
    style DBP fill:#4caf50,stroke:#2e7d32,color:#fff
    style DBR fill:#66bb6a,stroke:#388e3c,color:#fff
    style S3 fill:#2196f3,stroke:#1565c0,color:#fff
    style Q fill:#9c27b0,stroke:#6a1b9a,color:#fff
```

**What you get:**
- Auto-scaling Ghost pods on Kubernetes behind a load balancer
- Redis for shared sessions, cache, and queue management
- MySQL primary + read replica for high throughput
- CDN for static assets (images, CSS, JS)
- Background queue workers for async processing
- Shared object storage across all instances
- Automated failover and self-healing
- Zero-downtime rolling deploys

**Best for:** Production workloads, high-traffic applications, business-critical deployments.

</details>

---

## Security Configuration

The following environment variables **must** be set to non-default values before running in production:

| Variable | Description | Required |
|---|---|---|
| `MYSQL_PASSWORD` | MySQL password for the `ghost` user | **Yes** |
| `MYSQL_ROOT_PASSWORD` | MySQL root password | **Yes** |
| `GHOST_URL` | Public URL of your Ghost site (e.g. `https://example.com`) | **Yes** |
| `MYSQL_DATABASE` | MySQL database name (default: `ghost`) | No |
| `MYSQL_USER` | MySQL username (default: `ghost`) | No |

> **Warning:** Never use the placeholder passwords from `.env.example` in production. Generate strong, random passwords (e.g. `openssl rand -base64 32`).

Ghost handles its own admin setup on first run — no default admin credentials are shipped. Complete the setup wizard at `<your-url>/ghost` immediately after deployment.

---

### Maintained by [StackBlaze](https://stackblaze.com)

This template is actively maintained by StackBlaze. We perform **weekly automated checks** to ensure:

- **Up-to-date dependencies** — frameworks, libraries, and base images are kept current
- **Security scanning** — continuous monitoring for known vulnerabilities and CVEs
- **Best practices** — configurations follow current recommendations from upstream projects

Found an issue? [Open a ticket](https://github.com/stackblaze-templates/ghost/issues).
