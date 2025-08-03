# AutomatedAgilev1 Template

🎯 **Template Repository** for AI-driven agile development pipeline with specialized branch workflows.

## 📋 Use This Template

This is a template repository designed to be forked/cloned for actual development projects. It provides a complete AI-optimized branch structure for agile development workflows.

## 🏗️ Branch Structure

Each branch is optimized for a specific development phase with AI instructions, context, and Cursor rules:

```
main (coordination only)
├── discovery/
│   ├── 1-project-overview/     → Project charter & vision
│   ├── 2-requirements/         → Requirements gathering
│   ├── 3-architecture/         → System architecture
│   └── 4-module-breakdown/     → Module specifications
├── integration/
│   ├── 5-integration-requirements/ → Integration specs
│   ├── 6-integration-development/  → Integration layer code
│   └── 7-integration-test/         → Integration testing
├── modules/
│   ├── 8-module-requirements/      → Module requirements
│   ├── 9-module-development/       → Module implementation
│   ├── 10-module-test/             → Module testing
│   └── 11-module-integration-test/ → End-to-end testing
└── context/
    └── x-context-engineering/      → Cross-project coordination
```

## 🚀 How to Use This Template

### 1. Create Your Project from Template
```bash
# Option 1: Use GitHub's "Use this template" button (recommended)
# Click "Use this template" on GitHub to create a new repository

# Option 2: Clone this template locally
git clone https://github.com/Jita81/AutomatedAgilev1.git your-project-name
cd your-project-name
git remote set-url origin https://github.com/yourusername/your-project-name.git
```

### 2. Start Your Development Workflow
```bash
# Switch to any specialized branch for AI-optimized development
git checkout discovery/1-project-overview  # Project charter & vision
git checkout discovery/2-requirements      # Requirements gathering  
git checkout discovery/3-architecture      # System architecture
git checkout modules/9-module-development  # Module implementation

# Each branch provides:
# ✅ .cursorrules - Cursor IDE commands for that workflow
# ✅ ai-instructions/ - AI prompts optimized for that phase
# ✅ context/ - Templates and best practices
# ✅ rules/ - Quality standards and constraints
# ✅ docs/ - Deliverables folder (merges to main)
```

### 3. Template Features Ready to Use
- **12 specialized branches** with AI-optimized workflows
- **Branch isolation** - AI context stays in branches, deliverables merge to main
- **Cursor integration** - Specialized commands for each development phase
- **Quality standards** - Built-in rules and constraints for each workflow
- **Template libraries** - Context and examples for best practices

## 🧠 Branch Isolation

Each branch uses `.gitignore` to keep its AI instructions, context, and rules separate from main. Only the actual deliverables (code, docs, etc.) are merged back to coordinate progress.

## 🎯 Key Benefits

- **Specialized AI Context**: Each branch has AI instructions tuned for its specific use case
- **Optimized Workflows**: Cursor rules provide relevant commands for each development phase
- **Clean Separation**: Working files stay in branches, only deliverables merge to main
- **Focused Development**: Context switching between branches provides different AI personalities

## 📋 Branch-Specific Use Cases

- **Discovery Branches**: Requirements gathering, architecture planning, stakeholder communication
- **Integration Branches**: API design, service integration, system architecture
- **Module Branches**: Feature development, testing, module-specific implementation
- **Context Branch**: Cross-team coordination, knowledge management, project oversight