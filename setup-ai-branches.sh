#!/bin/bash

# Setup AI-optimized structure for all branches
# This script creates .cursorrules and README files for each specialized branch

declare -A branch_configs=(
    ["discovery/2-requirements"]="Requirements Analysis specialist|functional and non-functional requirements|Requirements gathering and validation"
    ["discovery/3-architecture"]="System Architecture specialist|system architecture and design|Architecture planning and design"
    ["discovery/4-module-breakdown"]="Module Design specialist|module specifications and breakdown|Module specification and planning"
    ["integration/5-integration-requirements"]="Integration Analysis specialist|integration requirements and APIs|Integration requirements analysis"
    ["integration/6-integration-development"]="Integration Development specialist|integration layer development|Integration development and implementation"
    ["integration/7-integration-test"]="Integration Testing specialist|integration testing and validation|Integration testing and quality assurance"
    ["modules/8-module-requirements"]="Module Requirements specialist|module-specific requirements|Module requirements analysis"
    ["modules/9-module-development"]="Module Development specialist|module implementation and coding|Module development and implementation"
    ["modules/10-module-test"]="Module Testing specialist|module testing and QA|Module testing and quality assurance"
    ["modules/11-module-integration-test"]="E2E Testing specialist|end-to-end and system testing|End-to-end testing and validation"
    ["context/x-context-engineering"]="Context Engineering specialist|cross-project coordination and knowledge management|Cross-project coordination and knowledge management"
)

create_branch_ai_structure() {
    local branch_name=$1
    local specialist_role=$2
    local focus_area=$3
    local description=$4
    
    echo "Setting up AI structure for: $branch_name"
    
    # Switch to branch
    git checkout "$branch_name"
    
    # Create .cursorrules
    cat > .cursorrules << EOF
# Cursor Rules for ${branch_name} Branch

## Primary Role
You are a ${specialist_role}. Focus on ${focus_area}.

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
- \`docs/\` - Deliverables and outputs
- \`ai-instructions/\` - AI prompts and guidance
- \`context/\` - Templates and examples
- \`rules/\` - Quality standards and constraints
EOF

    # Create ai-instructions README
    cat > ai-instructions/README.md << EOF
# AI Instructions for ${branch_name} Branch

## Purpose
AI prompts and instructions optimized for ${focus_area}.

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

## Add Your AI Prompts Here
Create specific prompt files for your workflows and use cases.
EOF

    # Create context README
    cat > context/README.md << EOF
# Context for ${branch_name} Branch

## Purpose
Templates, examples, and reference materials for ${focus_area}.

## Contents Structure
- **Templates**: Standardized formats and structures
- **Examples**: Sample deliverables and best practices
- **Best Practices**: Industry standards and proven approaches
- **Checklists**: Quality assurance and completeness checks

## Key Context Areas
- ${description^} frameworks and methodologies
- Industry standards and best practices
- Quality assurance templates
- Integration guidelines

## Add Your Context Here
Create specific context files, templates, and examples for your work.
EOF

    # Create rules README
    cat > rules/README.md << EOF
# Rules and Constraints for ${branch_name} Branch

## Purpose
Quality standards, constraints, and governance rules for ${focus_area}.

## Quality Standards
- All deliverables must meet professional standards
- Follow established templates and formats
- Include proper documentation and comments
- Require peer review and validation
- Maintain consistency across all outputs

## Documentation Standards
- Follow company documentation templates
- Include version control and change tracking
- Require stakeholder review and approval
- Maintain traceability to requirements

## Integration Requirements
- Consider system-wide implications
- Ensure compatibility with other components
- Follow established integration patterns
- Document all dependencies and interfaces

## Add Your Rules Here
Create specific rule files for quality standards, processes, and constraints.
EOF

    # Create docs README
    cat > docs/README.md << EOF
# ${branch_name^} Deliverables

## Purpose
Actual deliverables and outputs created during ${focus_area}.

## Key Deliverables
- Specifications and documentation
- Implementation code and configurations
- Test scenarios and validation reports
- Integration documentation

## Quality Standards
All deliverables should be:
- Professional and well-documented
- Stakeholder-approved where required
- Version controlled
- Ready for integration and handoff

## File Organization
Organize your deliverables logically with clear naming conventions.
EOF

    # Commit changes
    git add .
    git commit -m "Add AI-optimized structure for ${branch_name} branch"
    
    echo "✅ Completed setup for $branch_name"
}

# Process each branch
for branch_name in "${!branch_configs[@]}"; do
    IFS='|' read -r specialist_role focus_area description <<< "${branch_configs[$branch_name]}"
    create_branch_ai_structure "$branch_name" "$specialist_role" "$focus_area" "$description"
done

echo ""
echo "🎉 AI-optimized structure added to all specialized branches!"
echo "📋 Each branch now has:"
echo "   ✅ .cursorrules - Cursor IDE commands"
echo "   ✅ ai-instructions/ - AI prompts and guidance"
echo "   ✅ context/ - Templates and examples"
echo "   ✅ rules/ - Quality standards and constraints"
echo "   ✅ docs/ - Deliverables folder"
echo ""
echo "Ready for AI-driven development workflows! 🚀"