# AutomatedAgilev1 Deployment Guide

## 🚀 Deployment Overview

The AutomatedAgilev1 AI-driven development pipeline supports multiple deployment modes for different environments and use cases.

## 📋 Prerequisites

### System Requirements
- **Git**: Version control and branch management
- **Node.js**: v18.0.0 or higher
- **npm**: v9.0.0 or higher

### Deployment Mode Requirements

#### Docker Deployment
- **Docker**: Latest stable version
- **Docker Compose**: v2.0 or higher

#### Kubernetes Deployment (Coming Soon)
- **kubectl**: Kubernetes CLI
- **Helm**: v3.x (optional)

#### Local Development
- **Node.js**: v18.0.0 or higher
- **Git**: For branch management

## 🎯 Quick Start

### 1. Local Development Deployment
```bash
# Clone the repository
git clone https://github.com/Jita81/AutomatedAgilev1.git
cd AutomatedAgilev1

# Install dependencies
npm install

# Start local development server
npm run deploy:local
```

### 2. Docker Deployment
```bash
# Deploy with Docker
npm run deploy:dev

# Or use the deployment script directly
./deployment/scripts/deploy.sh --environment dev --mode docker
```

### 3. Validate Setup
```bash
# Validate deployment without running
npm run validate

# Check branch structure
npm run branches:list
```

## 🔧 Deployment Modes

### Docker Mode (Recommended)
- **Container orchestration** with Docker Compose
- **Multi-service architecture** (app, Redis, PostgreSQL, Nginx)
- **Development and production** configurations
- **Automatic service discovery** and networking

```bash
# Development environment
npm run deploy:dev

# Staging environment  
npm run deploy:staging

# Production environment
npm run deploy:prod
```

### Local Mode
- **Direct Node.js execution** for development
- **Minimal dependencies** and quick setup
- **Ideal for development** and testing

```bash
npm run deploy:local
```

### Kubernetes Mode (Coming Soon)
- **Scalable container orchestration**
- **Production-grade deployment**
- **Auto-scaling and load balancing**

## 📊 Service Architecture

### Core Services

#### AutomatedAgilev1 App
- **Port**: 3000 (HTTP), 9229 (Debug)
- **Function**: Main application server
- **Features**: API endpoints, branch management, documentation serving

#### Redis Cache
- **Port**: 6379
- **Function**: Session management and caching
- **Usage**: Branch context caching, user sessions

#### PostgreSQL Database
- **Port**: 5432
- **Function**: Metadata and project data storage
- **Usage**: Project tracking, user data, analytics

#### Nginx Reverse Proxy
- **Ports**: 80 (HTTP), 443 (HTTPS)
- **Function**: Load balancing and SSL termination
- **Usage**: Production traffic routing

#### Branch Manager Service
- **Port**: 8080
- **Function**: AI context switching and branch coordination
- **Usage**: Automated branch management and context optimization

## 🌍 Environment Configuration

### Development Environment
```bash
NODE_ENV=development
PORT=3000
BRANCH_CONTEXT=main
CURSOR_ENABLED=true
AI_OPTIMIZATION=true
```

### Staging Environment
```bash
NODE_ENV=staging
PORT=3000
REDIS_URL=redis://redis:6379
POSTGRES_URL=postgresql://user:pass@postgres:5432/automatedagile
```

### Production Environment
```bash
NODE_ENV=production
PORT=3000
# Add production-specific configurations
```

## 🚀 Deployment Scripts

### Main Deployment Script
```bash
./deployment/scripts/deploy.sh [OPTIONS]

OPTIONS:
    -e, --environment ENV    Deployment environment (dev|staging|prod)
    -m, --mode MODE         Deployment mode (docker|k8s|local)
    -v, --validate-only     Only validate setup, don't deploy
    -c, --clean             Clean existing deployment before deploying
    -h, --help              Show help message
```

### NPM Scripts
```bash
# Development
npm run deploy:dev          # Deploy to development with Docker
npm run deploy:local        # Deploy locally for development

# Staging & Production
npm run deploy:staging      # Deploy to staging environment
npm run deploy:prod         # Deploy to production environment

# Utilities
npm run validate            # Validate deployment setup
npm run clean               # Clean existing deployment
npm run branches:setup      # Setup branch structure
npm run branches:list       # List all specialized branches
npm run health              # Check service health
```

## 🔍 Health Monitoring

### Health Check Endpoints
- **Application Health**: `GET /health`
- **API Status**: `GET /api/status`
- **Branch Information**: `GET /api/branches`
- **Documentation**: `GET /api/docs`

### Service Monitoring
```bash
# Check application health
curl http://localhost:3000/health

# Check all services (Docker mode)
docker-compose -f deployment/docker/docker-compose.yml ps

# View logs
docker-compose -f deployment/docker/docker-compose.yml logs -f
```

## 🧠 AI Branch Integration

### Specialized Branch Workflows
The deployment includes 12 specialized branches optimized for different development phases:

#### Discovery Branches
- `discovery/1-project-overview` - Project charter & vision
- `discovery/2-requirements` - Requirements gathering
- `discovery/3-architecture` - System architecture
- `discovery/4-module-breakdown` - Module specifications

#### Integration Branches
- `integration/5-integration-requirements` - Integration specs
- `integration/6-integration-development` - Integration layer code
- `integration/7-integration-test` - Integration testing

#### Module Branches
- `modules/8-module-requirements` - Module requirements
- `modules/9-module-development` - Module implementation
- `modules/10-module-test` - Module testing
- `modules/11-module-integration-test` - End-to-end testing

#### Context Branch
- `context/x-context-engineering` - Cross-project coordination

### Branch Context Management
Each branch includes:
- **`.cursorrules`** - Cursor IDE commands for that workflow
- **`ai-instructions/`** - AI prompts optimized for specific use cases
- **`context/`** - Templates, examples, and knowledge base
- **`rules/`** - Quality standards and constraints
- **`docs/`** - Deliverable documentation

## 🔧 Troubleshooting

### Common Issues

#### Port Conflicts
```bash
# Check what's using port 3000
lsof -i :3000

# Kill process if needed
kill -9 <PID>
```

#### Docker Issues
```bash
# Clean Docker system
docker system prune -f

# Rebuild containers
docker-compose build --no-cache
```

#### Branch Issues
```bash
# Validate branch structure
npm run validate

# Recreate branches if needed
npm run branches:setup
```

### Debug Mode
```bash
# Start with debug logging
DEBUG=* npm run dev

# Docker debug mode
docker-compose -f deployment/docker/docker-compose.yml up
```

## 📈 Scaling and Performance

### Horizontal Scaling
- **Load balancing** with Nginx
- **Database connection pooling**
- **Redis clustering** for high availability
- **Container replication** with Docker Swarm or Kubernetes

### Performance Optimization
- **Static asset caching** with Nginx
- **API response caching** with Redis
- **Database query optimization**
- **Container resource limits**

## 🔒 Security Considerations

### Development Security
- **Environment variable management**
- **Container isolation**
- **Network segmentation**
- **Access control and authentication**

### Production Security
- **SSL/TLS termination**
- **Security headers** with Helmet.js
- **Database encryption**
- **Regular security updates**

## 📝 Deployment Checklist

### Pre-Deployment
- [ ] All 12 specialized branches exist and are configured
- [ ] AI context files (.cursorrules, ai-instructions/) are in place
- [ ] Environment variables are properly set
- [ ] Prerequisites are installed and verified

### Deployment
- [ ] Deployment script runs without errors
- [ ] All services start successfully
- [ ] Health checks pass
- [ ] API endpoints respond correctly

### Post-Deployment
- [ ] Monitor service logs for errors
- [ ] Verify branch switching works correctly
- [ ] Test AI-optimized workflows in each branch
- [ ] Validate deliverable flow to main branch

## 📞 Support and Maintenance

### Monitoring
- **Application logs**: Check for errors and performance issues
- **Service health**: Regular health check monitoring
- **Resource usage**: Monitor CPU, memory, and disk usage
- **Branch activity**: Track usage of specialized branches

### Maintenance
- **Regular updates**: Keep dependencies and base images updated
- **Backup strategy**: Regular backups of project data and configurations
- **Performance tuning**: Optimize based on usage patterns
- **Security patches**: Apply security updates promptly

---

## 🎉 Deployment Complete

Once deployed, the AutomatedAgilev1 pipeline provides:

✅ **12 specialized AI-optimized branches** for different development phases  
✅ **Cursor IDE integration** with branch-specific commands and context  
✅ **Automated deployment pipeline** with Docker and CI/CD support  
✅ **Branch isolation** keeping AI context separate from deliverables  
✅ **Cross-project coordination** capabilities  
✅ **Production-ready infrastructure** with monitoring and scaling support  

**The AI-driven development pipeline is now operational and ready for use!** 🚀