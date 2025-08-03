#!/bin/bash

# Array of branch configurations: "branch_name:purpose:primary_role"
branches=(
    "discovery/4-module-breakdown:Module Specification:Module Design specialist"
    "integration/5-integration-requirements:Integration Specs:Integration Analysis specialist"
    "integration/6-integration-development:Integration Code:Integration Development specialist"
    "integration/7-integration-test:Integration Testing:Integration Testing specialist"
    "modules/8-module-requirements:Module Requirements:Module Requirements specialist"
    "modules/9-module-development:Module Implementation:Module Development specialist"
    "modules/10-module-test:Module Testing:Module Testing specialist"
    "modules/11-module-integration-test:End-to-End Testing:E2E Testing specialist"
    "context/x-context-engineering:Cross-Project Coordination:Context Engineering specialist"
)

for branch_config in "${branches[@]}"; do
    IFS=':' read -r branch_name purpose primary_role <<< "$branch_config"
    
    echo "Creating branch: $branch_name"
    git checkout -b "$branch_name" 2>/dev/null || git checkout "$branch_name"
    
    # Create directory structure
    mkdir -p "docs/${branch_name}" "ai-instructions" "context" "rules"
    
    # Create basic .cursorrules
    cat > .cursorrules << EOF
# Cursor Rules for ${branch_name} Branch

## Primary Role
You are a ${primary_role}. Focus on ${purpose,,}.

## Purpose
${purpose}

## Key Commands
- \`/analyze\` - Analyze current requirements and context
- \`/design\` - Create design specifications
- \`/implement\` - Generate implementation code
- \`/test\` - Create test scenarios and validation
- \`/document\` - Create comprehensive documentation
- \`/review\` - Review and validate deliverables

## Focus Areas
1. ${purpose} planning and execution
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

    # Create basic README
    cat > "docs/${branch_name}/README.md" << EOF
# ${branch_name^} Branch

## Purpose
${purpose}

## Branch Capabilities
- Specialized for ${purpose,,}
- Optimized AI instructions and context
- Focused deliverable creation
- Quality-assured outputs

## Usage
1. Switch to this branch for ${purpose,,} work
2. Use available Cursor commands for workflow optimization
3. Follow branch-specific rules and constraints
4. Document all deliverables in docs folder

## AI Optimization
This branch is optimized for ${purpose,,} with specialized prompts and context.
EOF

    # Create basic AI instructions
    cat > "ai-instructions/prompts.md" << EOF
# AI Instructions for ${branch_name} Branch

## Core Mission
${purpose} with focus on quality, integration, and maintainability.

## AI Personality
- **Quality-Focused**: Ensure all deliverables meet high standards
- **Integration-Minded**: Consider system-wide implications
- **Documentation-Driven**: Create comprehensive documentation
- **Best-Practice-Oriented**: Follow industry standards and patterns

## Key Responsibilities
- ${purpose} planning and execution
- Quality assurance and validation
- Documentation and knowledge transfer
- Integration preparation and support
EOF

    git add .
    git commit -m "Setup ${branch_name} branch structure" >/dev/null 2>&1
    
done

echo "All branches created successfully!"
echo "Use 'git branch -a' to see all branches"