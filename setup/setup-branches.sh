#!/bin/bash

# Enhanced branch setup script for AutomatedAgilev1
# Creates all specialized branches with proper AI instructions and context

echo "🚀 Setting up AutomatedAgilev1 branch structure..."

# Define branch configurations
declare -A branches=(
    ["discovery/4-module-breakdown"]="Module Specification and breakdown planning"
    ["integration/5-integration-requirements"]="Integration requirements and API specifications"
    ["integration/6-integration-development"]="Integration layer development and implementation"
    ["integration/7-integration-test"]="Integration testing and validation"
    ["modules/8-module-requirements"]="Module-specific requirements analysis"
    ["modules/9-module-development"]="Module implementation and development"
    ["modules/10-module-test"]="Module testing and quality assurance"
    ["modules/11-module-integration-test"]="End-to-end and system integration testing"
)

# Function to create branch structure
create_branch_structure() {
    local branch_name=$1
    local description=$2
    
    echo "📁 Setting up branch: $branch_name"
    
    # Create or switch to branch
    git checkout -b "$branch_name" 2>/dev/null || git checkout "$branch_name"
    
    # Create directory structure
    mkdir -p "docs/$branch_name" "ai-instructions" "context" "rules"
    
    # Create specialized .cursorrules
    local role_name=$(echo "$branch_name" | sed 's/.*\///g' | sed 's/-/ /g' | sed 's/\b\w/\U&/g')
    cat > .cursorrules << EOF
# Cursor Rules for ${branch_name} Branch

## Primary Role
You are a ${role_name} specialist. Focus on ${description}.

## Key Commands
- \`/analyze\` - Analyze requirements and context
- \`/design\` - Create design specifications
- \`/implement\` - Generate implementation code
- \`/test\` - Create test scenarios and validation
- \`/document\` - Create comprehensive documentation
- \`/review\` - Review and validate deliverables
- \`/integrate\` - Prepare for integration with other components

## Focus Areas
1. ${description}
2. Quality assurance and validation
3. Documentation and handoff preparation
4. Integration with other system components
5. Performance and security considerations

## Output Format
- Clear, actionable specifications
- Well-documented code and configurations
- Comprehensive test scenarios
- Integration-ready deliverables

## Files to Work With
- \`docs/${branch_name}/\`
- Implementation code and configurations
- Test scripts and validation reports
EOF

    # Create README for the branch
    cat > "docs/$branch_name/README.md" << EOF
# ${branch_name} Branch

## Purpose
${description^}

## Branch Capabilities
- Specialized AI instructions for ${description}
- Optimized context and knowledge base
- Focused deliverable creation
- Quality-assured outputs

## Usage
1. Switch to this branch for ${description} work
2. Use available Cursor commands for workflow optimization
3. Follow branch-specific rules and constraints
4. Document all deliverables in docs folder

## AI Optimization
This branch is optimized for ${description} with specialized prompts and context.

## Key Deliverables
- Detailed specifications and designs
- Implementation code and configurations
- Test scenarios and validation reports
- Integration documentation
EOF

    # Create AI instructions
    cat > "ai-instructions/prompts.md" << EOF
# AI Instructions for ${branch_name} Branch

## Core Mission
${description^} with focus on quality, integration, and maintainability.

## AI Personality
- **Quality-Focused**: Ensure all deliverables meet high standards
- **Integration-Minded**: Consider system-wide implications
- **Documentation-Driven**: Create comprehensive documentation
- **Best-Practice-Oriented**: Follow industry standards and patterns

## Key Responsibilities
- ${description^} planning and execution
- Quality assurance and validation
- Documentation and knowledge transfer
- Integration preparation and support

## Context Sources
- Previous phase deliverables
- System architecture documentation
- Requirements specifications
- Industry best practices and standards
EOF

    # Commit the branch setup
    git add . >/dev/null 2>&1
    git commit -m "Setup ${branch_name} branch with AI instructions and templates" >/dev/null 2>&1
    
    echo "✅ Branch $branch_name setup complete"
}

# Create all branches
for branch_name in "\${!branches[@]}"; do
    create_branch_structure "$branch_name" "\${branches[$branch_name]}"
done

# Switch back to main
git checkout main >/dev/null 2>&1

echo ""
echo "🎉 All branches created successfully!"
echo ""
echo "📋 Available branches:"
git branch -a | grep -E "(discovery|integration|modules|context)" | sort
echo ""
echo "🔧 Usage:"
echo "  git checkout <branch-name>  # Switch to specialized branch"
echo "  # Use Cursor commands specific to that branch workflow"
echo ""
echo "✨ Ready for AI-driven development pipeline!"