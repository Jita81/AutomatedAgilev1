#!/bin/bash

# AutomatedAgilev1 Deployment Script
# Deploys the AI-driven development pipeline

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
DEPLOYMENT_DIR="$PROJECT_ROOT/deployment"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
    exit 1
}

# Help function
show_help() {
    cat << EOF
AutomatedAgilev1 Deployment Script

USAGE:
    $0 [OPTIONS]

OPTIONS:
    -e, --environment ENV    Deployment environment (dev|staging|prod)
    -m, --mode MODE         Deployment mode (docker|k8s|local)
    -v, --validate-only     Only validate setup, don't deploy
    -c, --clean             Clean existing deployment before deploying
    -h, --help              Show this help message

EXAMPLES:
    $0 --environment dev --mode docker
    $0 --environment prod --mode k8s --clean
    $0 --validate-only

EOF
}

# Parse command line arguments
ENVIRONMENT="dev"
MODE="docker"
VALIDATE_ONLY=false
CLEAN=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--environment)
            ENVIRONMENT="$2"
            shift 2
            ;;
        -m|--mode)
            MODE="$2"
            shift 2
            ;;
        -v|--validate-only)
            VALIDATE_ONLY=true
            shift
            ;;
        -c|--clean)
            CLEAN=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            error "Unknown option: $1"
            ;;
    esac
done

# Validation functions
validate_environment() {
    log "Validating deployment environment..."
    
    case $ENVIRONMENT in
        dev|staging|prod)
            success "Environment '$ENVIRONMENT' is valid"
            ;;
        *)
            error "Invalid environment: $ENVIRONMENT. Must be one of: dev, staging, prod"
            ;;
    esac
}

validate_prerequisites() {
    log "Checking prerequisites..."
    
    # Check if git is available
    if ! command -v git &> /dev/null; then
        error "Git is required but not installed"
    fi
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        error "Not in a git repository"
    fi
    
    # Validate branch structure
    log "Validating AI-driven pipeline branch structure..."
    
    expected_branches=(
        "discovery/1-project-overview"
        "discovery/2-requirements"
        "discovery/3-architecture"
        "discovery/4-module-breakdown"
        "integration/5-integration-requirements"
        "integration/6-integration-development"
        "integration/7-integration-test"
        "modules/8-module-requirements"
        "modules/9-module-development"
        "modules/10-module-test"
        "modules/11-module-integration-test"
        "context/x-context-engineering"
    )
    
    missing_branches=()
    for branch in "${expected_branches[@]}"; do
        if ! git show-ref --verify --quiet refs/heads/$branch 2>/dev/null; then
            missing_branches+=("$branch")
        fi
    done
    
    if [ ${#missing_branches[@]} -gt 0 ]; then
        warning "Missing branches: ${missing_branches[*]}"
        log "Creating missing branches..."
        for branch in "${missing_branches[@]}"; do
            git checkout -b "$branch" main 2>/dev/null || git checkout "$branch"
            success "Created/switched to branch: $branch"
        done
    fi
    
    success "Branch structure validated"
    
    # Check deployment mode prerequisites
    case $MODE in
        docker)
            if ! command -v docker &> /dev/null; then
                error "Docker is required but not installed"
            fi
            if ! command -v docker-compose &> /dev/null; then
                error "Docker Compose is required but not installed"
            fi
            ;;
        k8s)
            if ! command -v kubectl &> /dev/null; then
                error "kubectl is required but not installed"
            fi
            ;;
        local)
            if ! command -v node &> /dev/null; then
                error "Node.js is required but not installed"
            fi
            ;;
    esac
    
    success "Prerequisites validated"
}

validate_ai_context() {
    log "Validating AI context in branches..."
    
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    
    test_branches=(
        "discovery/1-project-overview"
        "discovery/2-requirements"
        "context/x-context-engineering"
    )
    
    for branch in "${test_branches[@]}"; do
        if git show-ref --verify --quiet refs/heads/$branch; then
            git checkout "$branch" 2>/dev/null || continue
            
            if [ -f .cursorrules ]; then
                success "AI context found in $branch"
            else
                warning "Missing .cursorrules in $branch"
            fi
        fi
    done
    
    git checkout "$current_branch" 2>/dev/null
}

# Deployment functions
deploy_docker() {
    log "Deploying with Docker..."
    
    cd "$DEPLOYMENT_DIR"
    
    if [ "$CLEAN" = true ]; then
        log "Cleaning existing deployment..."
        docker-compose -f docker/docker-compose.yml down -v || true
        docker system prune -f || true
    fi
    
    # Set environment variables
    export ENVIRONMENT="$ENVIRONMENT"
    export PROJECT_ROOT="$PROJECT_ROOT"
    
    # Start services
    log "Starting Docker services..."
    docker-compose -f docker/docker-compose.yml up -d
    
    # Wait for services to be ready
    log "Waiting for services to be ready..."
    sleep 10
    
    # Health check
    if curl -f http://localhost:3000/health 2>/dev/null; then
        success "Application is healthy and ready"
    else
        warning "Application may not be fully ready yet"
    fi
    
    success "Docker deployment complete"
}

deploy_local() {
    log "Deploying locally..."
    
    cd "$PROJECT_ROOT"
    
    # Install dependencies if package.json exists
    if [ -f package.json ]; then
        log "Installing dependencies..."
        npm install
    else
        log "Creating basic package.json..."
        npm init -y
        npm install express cors helmet
    fi
    
    # Start local development server
    log "Starting local development server..."
    if [ -f package.json ] && grep -q '"start"' package.json; then
        npm start &
    else
        echo "Local server setup complete. Use your preferred development setup."
    fi
    
    success "Local deployment complete"
}

# Main deployment function
deploy() {
    log "Starting AutomatedAgilev1 deployment..."
    log "Environment: $ENVIRONMENT"
    log "Mode: $MODE"
    
    case $MODE in
        docker)
            deploy_docker
            ;;
        local)
            deploy_local
            ;;
        k8s)
            error "Kubernetes deployment not yet implemented"
            ;;
        *)
            error "Invalid deployment mode: $MODE"
            ;;
    esac
    
    success "Deployment completed successfully!"
    
    cat << EOF

🎉 AutomatedAgilev1 AI-Driven Development Pipeline Deployed!

📋 Deployment Summary:
   Environment: $ENVIRONMENT
   Mode: $MODE
   All 12 specialized branches ready for use

🚀 Getting Started:
   1. Switch to any specialized branch: git checkout discovery/1-project-overview
   2. Use Cursor with optimized AI instructions for that workflow
   3. Create deliverables in the docs/ folder
   4. Switch branches for different development phases

🧠 AI-Optimized Branches Available:
   • discovery/1-project-overview     → Project charter & vision
   • discovery/2-requirements         → Requirements gathering
   • discovery/3-architecture         → System architecture
   • discovery/4-module-breakdown     → Module specifications
   • integration/*                   → Integration workflows
   • modules/*                       → Module development workflows
   • context/x-context-engineering   → Cross-project coordination

EOF
}

# Main execution
main() {
    log "AutomatedAgilev1 Deployment Script Starting..."
    
    validate_environment
    validate_prerequisites
    validate_ai_context
    
    if [ "$VALIDATE_ONLY" = true ]; then
        success "Validation complete. Deployment is ready."
        exit 0
    fi
    
    deploy
}

# Run main function
main "$@"