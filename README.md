# Alliance Genome Resources - Shared GitHub Workflows

This repository contains reusable GitHub workflows and organization-wide configurations for Alliance Genome Resources.

## Claude Code Review Workflow

A reusable workflow that adds AI-powered code review using Claude to any repository in the organization.

### Features

- 🤖 **AI Code Review**: Claude Sonnet 4 provides intelligent code analysis
- 🔍 **Focused Analysis**: Concentrates on critical bugs and database performance issues
- ✨ **Enhanced Analysis**: Optional zen MCP tools with o3 and Gemini models for deeper insights
- 💬 **Interactive**: Respond to @claude comments for targeted reviews
- 🛠️ **Flexible**: Configurable model, focus areas, and analysis depth

### Quick Setup

1. **Add Organization Secrets** (if not already done):
   - `ANTHROPIC_API_KEY` - Required for Claude
   - `GOOGLE_API_KEY` - Optional, for enhanced analysis with Gemini models
   - `OPENAI_API_KEY` - Optional, for enhanced analysis with o3 models

2. **Add Workflow to Your Repository**:
   Create `.github/workflows/claude-review.yml` in your repo:

```yaml
name: Claude Code Review

on:
  pull_request:
    types: [opened, synchronize, reopened]
  issue_comment:
    types: [created]

jobs:
  claude-review:
    uses: alliance-genome/.github/.github/workflows/claude-code-review.yml@main
    with:
      model: claude-sonnet-4-20250514
      use_zen_tools: true
    secrets:
      ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
      GOOGLE_API_KEY: ${{ secrets.GOOGLE_API_KEY }}
      OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
```

### Configuration Options

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `model` | Claude model to use | `claude-sonnet-4-20250514` | No |
| `max_turns` | Maximum conversation turns | `10` | No |
| `review_focus` | What to focus reviews on | `critical bugs and database performance` | No |
| `trigger_phrase` | Phrase for manual reviews | `@claude` | No |
| `use_zen_tools` | Enable enhanced analysis | `true` | No |
| `pr_size_threshold` | Line count for zen tools | `300` | No |
| `skip_threshold` | Line count to skip review | `25` | No |

### Usage Examples

#### Basic Setup
```yaml
jobs:
  claude-review:
    uses: alliance-genome/.github/.github/workflows/claude-code-review.yml@main
    secrets:
      ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
```

#### Custom Configuration
```yaml
jobs:
  claude-review:
    uses: alliance-genome/.github/.github/workflows/claude-code-review.yml@main
    with:
      model: claude-sonnet-4-20250514
      max_turns: "5"
      review_focus: "security vulnerabilities and performance"
      trigger_phrase: "@ai-review"
      use_zen_tools: false
    secrets:
      ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
```

#### Language-Specific Focus
```yaml
# For Java repositories
jobs:
  claude-review:
    uses: alliance-genome/.github/.github/workflows/claude-code-review.yml@main
    with:
      review_focus: "Java best practices, Spring Boot performance, and database efficiency"
    secrets:
      ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}

# For Python repositories  
jobs:
  claude-review:
    uses: alliance-genome/.github/.github/workflows/claude-code-review.yml@main
    with:
      review_focus: "Python code quality, async/await patterns, and SQL optimization"
    secrets:
      ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
```

### How It Works

1. **Automatic Reviews**: Triggers on PR open/sync for comprehensive analysis
2. **Manual Reviews**: Comment `@claude` on any PR or issue for targeted help
3. **Enhanced Analysis**: Uses multiple AI models (Claude, o3, Gemini) for thorough review
4. **Focused Scope**: Concentrates on critical issues to avoid noise

### Three-Tier Review System

The workflow automatically adjusts review depth based on PR size:

- **< 25 lines**: Reviews are skipped entirely to save costs (trivial changes)
- **25-300 lines**: Standard Claude review only 
- **> 300 lines**: Enhanced multi-model analysis with zen tools (o3, Gemini)

Manual reviews triggered by `@claude` always have access to zen tools regardless of PR size.

### Security

- ✅ All API keys stored as encrypted organization secrets
- ✅ No secrets exposed in workflow files
- ✅ Limited permissions (read contents, write PR comments)
- ✅ Open source workflow code for transparency

### Cost Management

- Reviews focus only on serious issues to minimize token usage
- Configurable `max_turns` to limit conversation length
- Organization-level API keys for centralized billing and limits

### Support

For issues with the shared workflow:
1. Check the [Actions tab](https://github.com/alliance-genome/.github/actions) for workflow runs
2. Review the [Claude Code Action documentation](https://docs.anthropic.com/en/docs/claude-code/github-actions)
3. Create an issue in this repository for workflow-specific problems