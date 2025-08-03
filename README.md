# AutomatedAgilev1

An AI-driven agile development pipeline with specialized branch workflows for different phases of software development.

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

## 🚀 How to Use

### 1. Setup
```bash
# Initialize all branches with AI-optimized structure
./setup/setup-branches.sh
```

### 2. Working with Specialized Branches

Each branch contains:
- **`ai-instructions/`** - AI prompts and guidance for that use case
- **`context/`** - Relevant context and knowledge base
- **`rules/`** - Branch-specific rules and constraints
- **`.cursorrules`** - Cursor IDE commands for that workflow

### 3. Example Workflow
```bash
# Work on requirements
git checkout discovery/2-requirements
# Branch now has AI instructions optimized for requirements gathering
# Cursor rules provide commands specific to requirements work

# Work on module development  
git checkout modules/9-module-development
# Branch now has AI instructions optimized for coding
# Cursor rules provide commands for development workflow
```

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