# Simple Mode for PDF8 (the Self-Hosted build)

Simple Mode is what powers the **Self-Hosted build** of PDF8 (`pdf8-simple`). It is **functionally identical** to the Commercial build that powers pdf8.com — every PDF tool is present and behaves the same. It just hides the marketing chrome (hero, FAQ, testimonials, footer) that only makes sense on the public pdf8.com site or on a commercial public-facing deployment.

> **Simple Mode is not a feature-reduced "lite" version.** Every PDF tool — merge, split, edit, sign, OCR, Office conversion, every other tool — works identically in both builds. The only difference is the marketing UI around the tools.

The Commercial build (`ghcr.io/alam00000/pdf8:latest`) is used by pdf8.com itself and by commercial license holders running public-facing PDF deployments where the full marketing site makes sense.

## What Simple Mode Hides

When enabled, Simple Mode hides the following pdf8.com-specific marketing UI:

- Navigation bar
- Hero section with marketing content
- Features section
- Security/compliance section
- FAQ section
- Testimonials section
- Support section
- Footer

It also updates the page title to "PDF Tools" and makes the tools section more prominent. **No PDF tools are removed or disabled.**

## How to Enable Simple Mode

### Method 1: Using Pre-built Simple Mode Image (Recommended)

Use the pre-built Simple Mode image directly:

**Using GitHub Container Registry (Recommended):**

```bash
# Docker
docker run -p 3000:8080 ghcr.io/alam00000/pdf8-simple:latest

# Podman
podman run -p 3000:8080 ghcr.io/alam00000/pdf8-simple:latest
```

**Using Docker Hub:**

```bash
# Docker
docker run -p 3000:8080 pdf8team/pdf8-simple:latest

# Podman
podman run -p 3000:8080 docker.io/pdf8team/pdf8-simple:latest
```

Or with Docker Compose / Podman Compose:

```yaml
services:
  PDF8:
    # Using GitHub Container Registry (Recommended)
    image: ghcr.io/alam00000/pdf8-simple:latest
    # Or using Docker Hub
    # image: pdf8team/pdf8-simple:latest
    container_name: PDF8
    restart: unless-stopped
    ports:
      - '3000:8080'
```

### Method 2: Using Docker Compose with Build

Build the image locally with Simple Mode enabled:

```bash
docker compose -f docker-compose.dev.yml build --build-arg SIMPLE_MODE=true
docker compose -f docker-compose.dev.yml up -d
```

### Method 3: Using Docker Build

Build the image with the SIMPLE_MODE build argument:

```bash
docker build --build-arg SIMPLE_MODE=true -t pdf8-simple .
docker run -p 3000:8080 pdf8-simple
```

### Method 4: Using npm Script (Easiest for Local Development)

Use the built-in npm script that handles everything:

```bash
npm run serve:simple
```

This command automatically:

- Sets `SIMPLE_MODE=true`
- Builds the project with Simple Mode enabled
- Serves the built files on `http://localhost:3000`

### Method 5: Using Environment Variables

Set the environment variable before building:

```bash
export SIMPLE_MODE=true
npm run build
npx serve dist -p 3000
```

## 🧪 Testing Simple Mode Locally

### Method 1: Using npm Script (Easiest for Development)

```bash
npm run serve:simple
```

This automatically builds and serves Simple Mode on `http://localhost:3000`.

### Method 2: Using Pre-built Image (Easiest for Production)

```bash
# Docker - Pull and run the Simple Mode image
docker pull ghcr.io/alam00000/pdf8-simple:latest
docker run -p 3000:8080 ghcr.io/alam00000/pdf8-simple:latest

# Podman
podman pull ghcr.io/alam00000/pdf8-simple:latest
podman run -p 3000:8080 ghcr.io/alam00000/pdf8-simple:latest
```

Open `http://localhost:3000` in your browser.

### Method 3: Build and Test Locally

```bash
# Build with simple mode
SIMPLE_MODE=true npm run build

# Serve the built files
npx serve dist -p 3000
```

Open `http://localhost:3000` in your browser.

### Method 4: Compare Both Builds Side-by-Side

```bash
# Commercial build (the pdf8.com look)
docker run -p 3000:8080 ghcr.io/alam00000/pdf8:latest

# Self-Hosted build (Simple Mode)
docker run -p 3001:8080 ghcr.io/alam00000/pdf8-simple:latest

# Podman users: replace 'docker' with 'podman'
```

- Commercial build: `http://localhost:3000`
- Self-Hosted build: `http://localhost:3001`

## 🔍 What to Look For

When Simple Mode is working correctly, you should see:

- ✅ Clean "PDF Tools" header (no marketing hero section)
- ✅ "Select a tool to get started" subtitle
- ✅ Search bar for tools
- ✅ All PDF tool cards organized by category
- ❌ No navigation bar
- ❌ No hero section with "The PDF Toolkit built for privacy"
- ❌ No features, FAQ, testimonials, or footer sections

## 📦 Available Container Images

### Self-Hosted build (Simple Mode) — recommended for self-hosting

**GitHub Container Registry (Recommended):**

- `ghcr.io/alam00000/pdf8-simple:latest`
- `ghcr.io/alam00000/pdf8-simple:v1.0.0` (versioned)

**Docker Hub:**

- `pdf8team/pdf8-simple:latest`
- `pdf8team/pdf8-simple:v1.0.0` (versioned)

### Commercial build — used by pdf8.com and commercial license holders

The full marketing site, including hero/FAQ/testimonials/footer. Pull this only if you specifically want the pdf8.com look — for example, you're running a public-facing PDF deployment under a commercial license.

**GitHub Container Registry (Recommended):**

- `ghcr.io/alam00000/pdf8:latest`
- `ghcr.io/alam00000/pdf8:v1.0.0` (versioned)

**Docker Hub:**

- `pdf8team/PDF8:latest`
- `pdf8team/PDF8:v1.0.0` (versioned)

## 🚀 Production Deployment Examples

### Docker Compose / Podman Compose

```yaml
services:
  PDF8:
    image: ghcr.io/alam00000/pdf8-simple:latest # Recommended
    # image: pdf8team/pdf8-simple:latest     # Alternative: Docker Hub
    container_name: PDF8
    restart: unless-stopped
    ports:
      - '80:8080'
    environment:
      - PUID=1000
      - PGID=1000
```

### Podman Quadlet (Linux Systemd)

Create `~/.config/containers/systemd/pdf8-simple.container`:

```ini
[Unit]
Description=PDF8 Simple Mode
After=network-online.target

[Container]
Image=ghcr.io/alam00000/pdf8-simple:latest
ContainerName=pdf8-simple
PublishPort=80:8080
AutoUpdate=registry

[Service]
Restart=always

[Install]
WantedBy=default.target
```

Enable and start:

```bash
systemctl --user daemon-reload
systemctl --user enable --now pdf8-simple
```

## ⚠️ Important Notes

- **Pre-built images**: Use `ghcr.io/alam00000/pdf8-simple:latest` for Simple Mode (recommended)
- **Environment variables**: `SIMPLE_MODE=true` only works during build, not runtime
- **Build-time optimization**: Simple Mode uses dead code elimination for smaller bundles
- **Same functionality**: All PDF tools work identically in both modes
