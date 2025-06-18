#!/bin/bash

# Cursor Configuration Validation Script
# This script validates Cursor configuration files for syntax and best practices

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
ERRORS=0
WARNINGS=0
PASSED=0

# Helper functions
log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((PASSED++))
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
    ((WARNINGS++))
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    ((ERRORS++))
}

# Check if required tools are available
check_dependencies() {
    local deps_missing=0
    
    if ! command -v jq &> /dev/null; then
        error "jq is required but not installed"
        ((deps_missing++))
    fi
    
    if ! command -v yamllint &> /dev/null; then
        warn "yamllint not found - YAML validation will be skipped"
    fi
    
    return $deps_missing
}

# Validate JSON configuration files
validate_json_config() {
    local file="$1"
    local filename=$(basename "$file")
    
    log "Validating JSON config: $filename"
    
    # Check JSON syntax
    if ! jq . "$file" > /dev/null 2>&1; then
        error "$filename: Invalid JSON syntax"
        return 1
    fi
    
    # Check for required fields based on file type
    case "$filename" in
        "config.json")
            validate_main_config "$file"
            ;;
        "development.json"|"production.json")
            validate_environment_config "$file"
            ;;
        "performance.json")
            validate_performance_config "$file"
            ;;
        "project.json")
            validate_project_config "$file"
            ;;
    esac
}

# Validate main configuration file
validate_main_config() {
    local file="$1"
    
    # Check for required fields
    if ! jq -e '.model' "$file" > /dev/null; then
        error "config.json: Missing required field 'model'"
    else
        success "config.json: Model configuration found"
    fi
    
    # Check temperature range
    local temp=$(jq -r '.temperature // 0.3' "$file")
    if (( $(echo "$temp > 1.0" | bc -l) )) || (( $(echo "$temp < 0.0" | bc -l) )); then
        warn "config.json: Temperature $temp is outside recommended range (0.0-1.0)"
    fi
    
    # Check context lines
    local context=$(jq -r '.contextLines // 100' "$file")
    if (( context > 1000 )); then
        warn "config.json: contextLines $context might impact performance"
    fi
}

# Validate environment-specific configuration
validate_environment_config() {
    local file="$1"
    local env=$(basename "$file" .json)
    
    # Environment-specific checks
    case "$env" in
        "development")
            # Development should have debug enabled
            if ! jq -e '.enableDebugMode' "$file" > /dev/null; then
                warn "development.json: Consider enabling debug mode for development"
            fi
            ;;
        "production")
            # Production should be more restrictive
            local temp=$(jq -r '.temperature // 0.3' "$file")
            if (( $(echo "$temp > 0.2" | bc -l) )); then
                warn "production.json: Consider lower temperature for production"
            fi
            
            if jq -e '.enableDebugMode == true' "$file" > /dev/null; then
                warn "production.json: Debug mode should be disabled in production"
            fi
            ;;
    esac
    
    success "$env.json: Environment configuration is valid"
}

# Validate performance configuration
validate_performance_config() {
    local file="$1"
    
    # Check cache settings
    if jq -e '.cacheEnabled == true' "$file" > /dev/null; then
        if ! jq -e '.cacheTimeout' "$file" > /dev/null; then
            warn "performance.json: Cache enabled but no timeout specified"
        fi
    fi
    
    # Check exclude patterns
    if ! jq -e '.excludePatterns | length > 0' "$file" > /dev/null; then
        warn "performance.json: No exclude patterns defined - consider adding common exclusions"
    fi
    
    success "performance.json: Performance configuration is valid"
}

# Validate project configuration
validate_project_config() {
    local file="$1"
    
    # Check if extends field exists
    if ! jq -e '.extends' "$file" > /dev/null; then
        warn "project.json: No 'extends' field found - consider extending base config"
    fi
    
    success "project.json: Project configuration is valid"
}

# Validate MDC rule files
validate_mdc_rules() {
    local file="$1"
    local filename=$(basename "$file")
    
    log "Validating rule file: $filename"
    
    # Check YAML front matter
    if ! head -1 "$file" | grep -q "^---$"; then
        error "$filename: Missing YAML front matter delimiter"
        return 1
    fi
    
    # Extract and validate front matter
    local front_matter=$(sed -n '1,/^---$/p' "$file" | head -n -1 | tail -n +2)
    
    if [ -z "$front_matter" ]; then
        error "$filename: Empty YAML front matter"
        return 1
    fi
    
    # Check for required fields
    if ! echo "$front_matter" | grep -q "^description:"; then
        error "$filename: Missing 'description' field in front matter"
    fi
    
    # Check for globs field (recommended)
    if ! echo "$front_matter" | grep -q "^globs:"; then
        warn "$filename: No 'globs' field found - consider adding file patterns"
    fi
    
    # Validate YAML syntax if yamllint is available
    if command -v yamllint &> /dev/null; then
        if ! echo "$front_matter" | yamllint - > /dev/null 2>&1; then
            error "$filename: Invalid YAML syntax in front matter"
        fi
    fi
    
    # Check file size (rules shouldn't be too large)
    local file_size=$(wc -l < "$file")
    if (( file_size > 500 )); then
        warn "$filename: File is quite large ($file_size lines) - consider splitting"
    fi
    
    success "$filename: Rule file structure is valid"
}

# Check for conflicting rules
check_rule_conflicts() {
    local rules_dir="$1"
    
    log "Checking for potential rule conflicts..."
    
    # Find overlapping glob patterns
    local temp_file=$(mktemp)
    find "$rules_dir" -name "*.mdc" -exec grep -l "globs:" {} \; | while read -r file; do
        sed -n '/^globs:/,/^[a-zA-Z]/p' "$file" | grep -E "^\s*-" | sed 's/^\s*-\s*//' >> "$temp_file"
    done
    
    # Check for duplicate patterns
    if [ -s "$temp_file" ]; then
        local duplicates=$(sort "$temp_file" | uniq -d)
        if [ -n "$duplicates" ]; then
            warn "Found potentially conflicting glob patterns:"
            echo "$duplicates" | while read -r pattern; do
                echo "  - $pattern"
            done
        else
            success "No conflicting glob patterns found"
        fi
    fi
    
    rm -f "$temp_file"
}

# Generate validation report
generate_report() {
    echo
    echo "=================================="
    echo "Cursor Configuration Validation Report"
    echo "=================================="
    echo "✅ Passed: $PASSED"
    echo "⚠️  Warnings: $WARNINGS"
    echo "❌ Errors: $ERRORS"
    echo "=================================="
    
    if (( ERRORS > 0 )); then
        echo "❌ Validation FAILED - Please fix the errors above"
        return 1
    elif (( WARNINGS > 0 )); then
        echo "⚠️  Validation PASSED with warnings - Consider addressing them"
        return 0
    else
        echo "✅ Validation PASSED - Configuration looks good!"
        return 0
    fi
}

# Main validation function
main() {
    local config_dir="${1:-.cursor}"
    
    echo "🔍 Cursor Configuration Validator"
    echo "Validating configuration in: $config_dir"
    echo
    
    # Check dependencies
    if ! check_dependencies; then
        echo "Please install missing dependencies and try again"
        exit 1
    fi
    
    # Check if config directory exists
    if [ ! -d "$config_dir" ]; then
        error "Configuration directory not found: $config_dir"
        generate_report
        exit 1
    fi
    
    # Validate JSON configuration files
    find "$config_dir" -name "*.json" -type f | while read -r file; do
        validate_json_config "$file"
    done
    
    # Validate MDC rule files
    find "$config_dir" -name "*.mdc" -type f | while read -r file; do
        validate_mdc_rules "$file"
    done
    
    # Check for rule conflicts
    if [ -d "$config_dir/rules" ]; then
        check_rule_conflicts "$config_dir/rules"
    fi
    
    # Generate final report
    generate_report
}

# Run main function with provided arguments
main "$@" 