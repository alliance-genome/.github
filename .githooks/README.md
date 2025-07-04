# Git Hooks for Alliance .github Repository

This directory contains git hooks to prevent accidental commits of sensitive data.

## Setup

Run the setup script from the repository root:
```bash
./setup-git-hooks.sh
```

## What's Protected

The pre-commit hook prevents committing:

### Sensitive Files
- `.env` files (any variation)
- Private keys (`.pem`, `.key`, etc.)
- Certificates (`.cert`, `.crt`, `.p12`, `.pfx`)
- SSH keys (`id_rsa`, `id_dsa`, etc.)
- AWS credentials

### Sensitive Content Patterns
- Private key headers (`BEGIN RSA`, `BEGIN PRIVATE KEY`, etc.)
- API keys:
  - AWS access keys (`AKIA...`)
  - GitHub tokens (`github_pat_`, `ghp_`, `ghs_`)
  - Anthropic API keys (`sk-ant-`)
  - OpenAI API keys (`sk-proj-`)
  - Google API keys
- Any file containing common API key environment variable names

## Bypassing Checks (Not Recommended)

If you absolutely need to bypass the checks:
```bash
git commit --no-verify
```

**⚠️ WARNING**: Only bypass if you're 100% certain the commit is safe!

## Troubleshooting

If the hooks aren't working:
1. Ensure you ran `./setup-git-hooks.sh`
2. Check that `.githooks/pre-commit` is executable
3. Verify with: `git config core.hooksPath` (should show `.githooks`)

## Disabling Hooks

To temporarily disable:
```bash
git commit --no-verify
```

To permanently disable (not recommended):
```bash
git config --unset core.hooksPath
```