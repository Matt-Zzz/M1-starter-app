# 🐧 Ubuntu Testing Guide

## Testing Options for CPEN 321 M1 Project

### Option 1: Docker Ubuntu Container (Recommended)

#### Quick Test with Ubuntu Container
```bash
# Run a temporary Ubuntu container with your project
docker run -it --rm -v $(pwd):/workspace ubuntu:22.04 bash

# Inside the container, install dependencies
apt update && apt install -y curl git nodejs npm mongodb

# Navigate to your project
cd /workspace

# Test backend
cd backend
npm install
npm run build
npm start

# Test frontend (in another terminal)
cd frontend
./gradlew build
```

#### Persistent Ubuntu Development Environment
```bash
# Create a development container
docker run -it --name cpen321-ubuntu \
  -v $(pwd):/workspace \
  -p 3000:3000 \
  -p 3001:3001 \
  -p 27017:27017 \
  ubuntu:22.04 bash

# Install all dependencies
apt update
apt install -y curl git nodejs npm mongodb openjdk-17-jdk

# Set up environment
cd /workspace
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc
source ~/.bashrc
```

### Option 2: GitHub Actions Ubuntu Runner

Your project already has GitHub Actions set up! You can test on Ubuntu by:

1. **Push to GitHub** - triggers Ubuntu build
2. **Check Actions tab** in your GitHub repo
3. **View build logs** to see Ubuntu-specific issues

#### Current GitHub Actions Workflow
```yaml
# .github/workflows/main.yml
name: CI/CD Pipeline
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest  # ← This is Ubuntu!
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
      - name: Install dependencies
        run: cd backend && npm ci
      - name: Build
        run: cd backend && npm run build
      - name: Test with Docker
        run: docker-compose up --build -d
```

### Option 3: Local Ubuntu VM

#### Using VirtualBox/VMware
1. **Download Ubuntu 22.04 LTS**
2. **Create VM** with 4GB RAM, 20GB disk
3. **Install dependencies**:
   ```bash
   sudo apt update
   sudo apt install -y curl git nodejs npm mongodb openjdk-17-jdk
   ```
4. **Clone your project**:
   ```bash
   git clone <your-repo-url>
   cd M1-starter-app
   ```

#### Using WSL2 (Windows) or Parallels (Mac)
```bash
# Install Ubuntu in WSL2/Parallels
wsl --install -d Ubuntu-22.04

# Or use Parallels Desktop with Ubuntu template
# Then follow the same setup as VM
```

### Option 4: Cloud Ubuntu Instance

#### AWS EC2 Ubuntu
```bash
# Launch Ubuntu 22.04 t2.micro instance
# SSH into instance
ssh -i your-key.pem ubuntu@your-instance-ip

# Install dependencies
sudo apt update
sudo apt install -y curl git nodejs npm mongodb openjdk-17-jdk

# Clone and test
git clone <your-repo-url>
cd M1-starter-app
```

#### DigitalOcean Droplet
```bash
# Create Ubuntu 22.04 droplet
# SSH and follow same setup as AWS
```

## 🧪 Testing Checklist

### Backend Testing on Ubuntu
- [ ] Node.js installation and version check
- [ ] npm dependencies installation
- [ ] TypeScript compilation
- [ ] MongoDB connection
- [ ] API endpoints testing
- [ ] Docker build and run
- [ ] Environment variables loading

### Frontend Testing on Ubuntu
- [ ] Java 17 installation
- [ ] Android SDK setup (if needed)
- [ ] Gradle build
- [ ] APK generation
- [ ] Network connectivity to backend

### Integration Testing
- [ ] Backend API responses
- [ ] Database operations
- [ ] File uploads
- [ ] Authentication flow
- [ ] Google Calendar integration

## 🚀 Quick Ubuntu Test Commands

### Test Backend
```bash
# Check Node.js
node --version  # Should be 18+ or 20

# Check npm
npm --version

# Install and build
cd backend
npm install
npm run build

# Test with Docker
docker-compose up --build
```

### Test Frontend
```bash
# Check Java
java --version  # Should be 17+

# Check Gradle
./gradlew --version

# Build Android app
cd frontend
./gradlew build
```

## 🔧 Ubuntu-Specific Issues to Watch For

### Common Problems
1. **Permission issues** with Docker
2. **Port conflicts** (different from macOS)
3. **Path differences** (forward slashes)
4. **Package manager differences** (apt vs brew)
5. **Java version conflicts**

### Solutions
```bash
# Fix Docker permissions
sudo usermod -aG docker $USER
newgrp docker

# Check ports
sudo netstat -tulpn | grep :3000

# Fix Java issues
sudo update-alternatives --config java
```

## 📊 Performance Comparison

| Platform | Build Time | Memory Usage | Compatibility |
|----------|------------|--------------|---------------|
| macOS    | ~2-3 min   | ~2GB         | Native        |
| Ubuntu   | ~1-2 min   | ~1.5GB       | Production    |
| Docker   | ~3-4 min   | ~2.5GB       | Isolated      |

## 🎯 Recommended Testing Strategy

1. **Start with GitHub Actions** (easiest)
2. **Use Docker Ubuntu container** (most realistic)
3. **Test on actual Ubuntu VM** (most thorough)
4. **Deploy to cloud Ubuntu** (production-like)

## 📝 Testing Results Template

```markdown
## Ubuntu Testing Results

### Environment
- OS: Ubuntu 22.04 LTS
- Node.js: v20.x.x
- Java: 17.x.x
- Docker: 24.x.x

### Backend Tests
- [ ] npm install: ✅/❌
- [ ] npm run build: ✅/❌
- [ ] npm start: ✅/❌
- [ ] Docker build: ✅/❌
- [ ] API endpoints: ✅/❌

### Frontend Tests
- [ ] Gradle build: ✅/❌
- [ ] APK generation: ✅/❌
- [ ] Network connectivity: ✅/❌

### Issues Found
- Issue 1: Description
- Issue 2: Description

### Performance
- Build time: X minutes
- Memory usage: X GB
- CPU usage: X%
```

## 🚨 Emergency Ubuntu Testing

If you need to test quickly:

```bash
# One-liner Ubuntu test
docker run -it --rm -v $(pwd):/workspace ubuntu:22.04 bash -c "
  apt update && apt install -y nodejs npm && 
  cd /workspace/backend && 
  npm install && 
  npm run build && 
  echo 'Backend build successful on Ubuntu!'
"
```

This will give you a quick Ubuntu environment to test your backend build!

