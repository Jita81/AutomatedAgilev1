#!/usr/bin/env node

/**
 * AutomatedAgilev1 - AI-Driven Development Pipeline Server
 * Main application server for the branch-based AI development workflow
 */

const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const path = require('path');
const fs = require('fs');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;
const NODE_ENV = process.env.NODE_ENV || 'development';

// Security middleware
app.use(helmet());

// CORS configuration
app.use(cors({
  origin: NODE_ENV === 'production' ? 
    ['https://yourdomain.com'] : 
    ['http://localhost:3000', 'http://localhost:3001'],
  credentials: true
}));

// Body parsing middleware
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Logging middleware
app.use((req, res, next) => {
  const timestamp = new Date().toISOString();
  console.log(`[${timestamp}] ${req.method} ${req.path} - ${req.ip}`);
  next();
});

// Static file serving
app.use('/docs', express.static(path.join(__dirname, 'docs')));
app.use('/deployment', express.static(path.join(__dirname, 'deployment')));

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    environment: NODE_ENV,
    version: require('./package.json').version,
    pipeline: 'AutomatedAgilev1',
    branches: {
      total: 12,
      categories: ['discovery', 'integration', 'modules', 'context']
    }
  });
});

// API endpoints
app.get('/api/branches', async (req, res) => {
  try {
    const { execSync } = require('child_process');
    const branches = execSync('git branch -a', { encoding: 'utf8' })
      .split('\n')
      .filter(branch => branch.includes('discovery/') || 
                       branch.includes('integration/') || 
                       branch.includes('modules/') || 
                       branch.includes('context/'))
      .map(branch => branch.trim().replace('* ', '').replace('remotes/origin/', ''))
      .filter(branch => branch.length > 0);

    const categorized = {
      discovery: branches.filter(b => b.startsWith('discovery/')),
      integration: branches.filter(b => b.startsWith('integration/')),
      modules: branches.filter(b => b.startsWith('modules/')),
      context: branches.filter(b => b.startsWith('context/'))
    };

    res.json({
      success: true,
      total: branches.length,
      branches: categorized,
      all: branches
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: 'Failed to retrieve branches',
      message: error.message
    });
  }
});

// Branch context endpoint
app.get('/api/branch/:branchName/context', (req, res) => {
  try {
    const { branchName } = req.params;
    const contextPath = path.join(__dirname, 'context', `${branchName.replace('/', '-')}.json`);
    
    if (fs.existsSync(contextPath)) {
      const context = JSON.parse(fs.readFileSync(contextPath, 'utf8'));
      res.json({
        success: true,
        branch: branchName,
        context
      });
    } else {
      res.status(404).json({
        success: false,
        error: 'Branch context not found',
        branch: branchName
      });
    }
  } catch (error) {
    res.status(500).json({
      success: false,
      error: 'Failed to retrieve branch context',
      message: error.message
    });
  }
});

// Pipeline status endpoint
app.get('/api/status', (req, res) => {
  res.json({
    pipeline: 'AutomatedAgilev1',
    status: 'operational',
    features: {
      aiOptimizedBranches: true,
      cursorIntegration: true,
      specializedWorkflows: true,
      branchIsolation: true,
      deliverableFlow: true
    },
    branches: {
      discovery: 4,
      integration: 3,
      modules: 4,
      context: 1,
      total: 12
    },
    deployment: {
      environment: NODE_ENV,
      containerized: process.env.DOCKER_CONTAINER === 'true',
      version: require('./package.json').version
    }
  });
});

// Documentation endpoint
app.get('/api/docs', (req, res) => {
  const docsPath = path.join(__dirname, 'docs');
  const structure = {};
  
  try {
    function buildStructure(dir, obj) {
      const items = fs.readdirSync(dir);
      items.forEach(item => {
        const fullPath = path.join(dir, item);
        const relativePath = path.relative(docsPath, fullPath);
        
        if (fs.statSync(fullPath).isDirectory()) {
          obj[item] = {};
          buildStructure(fullPath, obj[item]);
        } else if (item.endsWith('.md')) {
          obj[item] = {
            path: relativePath,
            size: fs.statSync(fullPath).size,
            modified: fs.statSync(fullPath).mtime
          };
        }
      });
    }
    
    if (fs.existsSync(docsPath)) {
      buildStructure(docsPath, structure);
    }
    
    res.json({
      success: true,
      documentation: structure,
      basePath: '/docs'
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: 'Failed to build documentation structure',
      message: error.message
    });
  }
});

// Root endpoint
app.get('/', (req, res) => {
  res.json({
    name: 'AutomatedAgilev1',
    description: 'AI-driven agile development pipeline with specialized branch workflows',
    version: require('./package.json').version,
    environment: NODE_ENV,
    endpoints: {
      health: '/health',
      branches: '/api/branches',
      status: '/api/status',
      docs: '/api/docs',
      branchContext: '/api/branch/:branchName/context'
    },
    features: [
      '12 specialized AI-optimized branches',
      'Cursor IDE integration with branch-specific rules',
      'Context isolation and deliverable flow',
      'Cross-project coordination capabilities',
      'Automated deployment pipeline'
    ]
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(`[ERROR] ${err.stack}`);
  res.status(500).json({
    error: 'Internal Server Error',
    message: NODE_ENV === 'development' ? err.message : 'Something went wrong'
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    error: 'Not Found',
    message: 'The requested resource was not found',
    path: req.path
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`
🚀 AutomatedAgilev1 Pipeline Server Started

📊 Server Information:
   Port: ${PORT}
   Environment: ${NODE_ENV}
   Version: ${require('./package.json').version}

🧠 AI-Driven Pipeline Ready:
   ✅ 12 specialized branches configured
   ✅ Cursor integration optimized
   ✅ Branch isolation enabled
   ✅ Deliverable flow operational

🔗 Available Endpoints:
   Health Check: http://localhost:${PORT}/health
   API Status:   http://localhost:${PORT}/api/status
   Branches:     http://localhost:${PORT}/api/branches
   Docs:         http://localhost:${PORT}/api/docs

🎯 Ready for AI-driven development workflows!
  `);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('SIGTERM received, shutting down gracefully...');
  process.exit(0);
});

process.on('SIGINT', () => {
  console.log('SIGINT received, shutting down gracefully...');
  process.exit(0);
});

module.exports = app;