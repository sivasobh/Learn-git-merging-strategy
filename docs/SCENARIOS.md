# 🎯 Real-World GitFlow Scenarios - Step-by-Step Practice

This document provides real-world scenarios you should execute in this playground to master GitFlow!

## 📋 Table of Contents
1. [Scenario 1: Initial Project Setup](#scenario-1-initial-project-setup)
2. [Scenario 2: Develop First Feature](#scenario-2-develop-first-feature)
3. [Scenario 3: Multiple Parallel Features](#scenario-3-multiple-parallel-features)
4. [Scenario 4: Create Release](#scenario-4-create-release)
5. [Scenario 5: Fix Critical Production Bug with Hotfix](#scenario-5-fix-critical-production-bug-with-hotfix)
6. [Scenario 6: Handle Merge Conflicts](#scenario-6-handle-merge-conflicts)
7. [Scenario 7: Release With Hotfix in Flight](#scenario-7-release-with-hotfix-in-flight)

---

## Scenario 1: Initial Project Setup

**Objective**: Initialize the project structure and create main/develop branches with v1.0.0 tag.

**Context**: You're starting a new project. You need to set up the repository with proper branching for team collaboration.

### Step-by-Step Execution

```bash
# Step 1: Navigate to project directory
cd c:\Users\USER\Documents\GitHubProjects\Learn-git-merging-strategy

# Step 2: Verify git is initialized
git status

# Step 3: Configure git locally (if not done)
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Step 4: Create initial commit on temporary branch
git add .
git commit -m "Initial project structure with documentation"

# Step 5: Rename current branch to main (if needed)
git branch -M main

# Step 6: List branches
git branch -a

# Step 7: Create develop branch from main
git branch develop

# Step 8: Verify branches exist
git branch -a

# Step 9: Create first release tag on main
git tag -a v1.0.0 -m "Initial stable release v1.0.0"

# Step 10: Verify tag created
git tag -l -n5

# Step 11: View git log with visualization
git log --graph --oneline --all --decorate
```

### Expected Output

```
* abc1234 (HEAD -> main, tag: v1.0.0) Initial project structure with documentation
  develop

Branches created:
- main (production)
- develop (integration)

Tag created:
- v1.0.0 → points to abc1234
```

### Key Learning Points

- ✅ `main` is production-ready code
- ✅ `develop` is where features integrate
- ✅ Tags mark release points
- ✅ `--decorate` shows branch/tag info in logs

---

## Scenario 2: Develop First Feature

**Objective**: Create a feature branch, develop a feature, and merge it back to develop.

**Context**: The team wants to add user authentication. You create a feature branch and work on it independently.

### Step-by-Step Execution

```bash
# Step 1: Switch to develop
git checkout develop

# Step 2: Create feature branch from develop
git checkout -b feature/user-authentication

# Step 3: Create a feature file (simulating development)
cat > feature_auth.txt << EOF
User Authentication Feature - v1.0

Features:
- User registration form
- Login functionality
- Password reset
- Email verification
- JWT token generation

Status: In Development
Developer: Your Name
Created: 2026-02-10
EOF

# Step 4: Create another feature file
cat > feature_jwt.txt << EOF
JWT Token Validation Module

Implementation:
- Token creation on login
- Token validation middleware
- Token refresh mechanism
- Token expiration handling

Status: In Development
EOF

# Step 5: Stage and commit
git add feature_auth.txt feature_jwt.txt
git commit -m "Add user authentication module structure"

# Step 6: Make additional improvements
cat > feature_auth_endpoints.txt << EOF
Authentication API Endpoints:

POST /api/auth/register
- Create new user account
- Validate email format
- Hash password with bcrypt

POST /api/auth/login
- Validate credentials
- Return JWT token
- Set refresh token cookie

POST /api/auth/logout
- Invalidate token
- Clear refresh token

GET /api/auth/verify
- Verify current token
- Return user info

POST /api/auth/refresh
- Create new token using refresh token
EOF

git add feature_auth_endpoints.txt
git commit -m "Define authentication API endpoints"

# Step 7: View commits on this feature
git log feature/user-authentication -3 --oneline

# Step 8: View difference from develop
git diff develop..feature/user-authentication

# Step 9: Switch to develop
git checkout develop

# Step 10: Ensure develop is up to date
git pull origin develop  # Would fail without remote, that's OK

# Step 11: Merge feature with non-fast-forward
git merge --no-ff feature/user-authentication -m "Merge feature/user-authentication: Add user authentication module"

# Step 12: View log showing merge
git log --graph --oneline --all -5

# Step 13: Delete local feature branch
git branch -d feature/user-authentication

# Step 14: Verify branch deleted
git branch -a
```

### Expected Output

```
* 1234567 (HEAD -> develop) Merge feature/user-authentication: Add user authentication module
|\
| * 8901234 Define authentication API endpoints
| * 5678901 Add user authentication module structure
|/
* abc1234 (tag: v1.0.0, main) Initial project structure with documentation
```

### Files Created

- feature_auth.txt
- feature_jwt.txt
- feature_auth_endpoints.txt

### Key Learning Points

- ✅ Feature branches always come from `develop`
- ✅ Work with multiple commits before merging
- ✅ Use `--no-ff` to preserve branch history (shows merge commit)
- ✅ Delete branches after merging (cleanup)
- ✅ The merge commit message shows feature name

---

## Scenario 3: Multiple Parallel Features

**Objective**: Develop two features simultaneously on separate branches.

**Context**: Your team works on payments and email notifications in parallel. Both merge to develop without conflicts.

### Step-by-Step Execution

```bash
# Step 1: Create first parallel feature branch
git checkout develop
git checkout -b feature/payment-processing

# Step 2: Create payment feature files
cat > feature_stripe_integration.txt << EOF
Stripe Payment Integration

Features:
- Connect to Stripe API
- Create payment intents
- Handle webhooks
- Process refunds
- PCI compliance

Status: In Development
EOF

cat > feature_payment_ui.txt << EOF
Payment UI Components

Components:
- Payment form with card details
- Amount input validation
- Currency selector
- Payment status display
- Receipt generation

Status: In Development
EOF

git add feature_stripe_integration.txt feature_payment_ui.txt
git commit -m "Add payment processing module structure"

# Step 3: Create second parallel feature branch from develop
git checkout develop
git checkout -b feature/email-notifications

# Step 4: Create email feature files
cat > feature_email_sender.txt << EOF
Email Notification Service

Features:
- SMTP configuration
- Email template engine
- Scheduled email sending
- Retry logic
- Bounce handling

Status: In Development
EOF

cat > feature_email_templates.txt << EOF
Email Templates

Templates:
- Welcome email
- Order confirmation
- Shipping notification
- Password reset
- Newsletter

Status: In Development
EOF

git add feature_email_sender.txt feature_email_templates.txt
git commit -m "Add email notification module structure"

# Step 5: Add more commits to feature/email-notifications
cat > feature_email_queue.txt << EOF
Email Queue System

Implementation:
- Queue database schema
- Worker process management
- Duplicate prevention
- Dead letter queue

Status: In Development
EOF

git add feature_email_queue.txt
git commit -m "Add email queue management system"

# Step 6: View both features
git log --graph --oneline --all --decorate -10

# Step 7: Merge first feature back to develop
git checkout develop
git merge --no-ff feature/payment-processing -m "Merge feature/payment-processing: Add Stripe integration"

# Step 8: Merge second feature to develop (no conflicts because different files)
git merge --no-ff feature/email-notifications -m "Merge feature/email-notifications: Add email notification system"

# Step 9: View merged log
git log develop --graph --oneline --decorate -10

# Step 10: Delete both feature branches
git branch -d feature/payment-processing feature/email-notifications

# Step 11: View final state
git branch -a
git log develop --oneline -5
```

### Expected Output

```
* 9876543 (HEAD -> develop) Merge feature/email-notifications: Add email notification system
|\
| * 3456789 Add email queue management system
| * 2345678 Add email notification module structure
* | 8765432 Merge feature/payment-processing: Add Stripe integration
|\ \
| |/
| * 1234567 Add payment processing module structure
|/
* 7654321 Merge feature/user-authentication: Add user authentication module
...
```

### Files Created

- feature_stripe_integration.txt
- feature_payment_ui.txt
- feature_email_sender.txt
- feature_email_templates.txt
- feature_email_queue.txt

### Key Learning Points

- ✅ Multiple branches can exist simultaneously
- ✅ No conflicts when branches modify different files
- ✅ Each branch works independently from develop
- ✅ Merge order matters for understanding Git graph
- ✅ Each feature has its own merge commit

---

## Scenario 4: Create Release

**Objective**: Prepare a release (v1.1.0) with version bumping while development continues.

**Context**: After several features, you need to prepare v1.1.0 for deployment while the team continues working on v1.2.0 features in develop.

### Step-by-Step Execution

```bash
# Step 1: Ensure develop is up to date and on clean state
git checkout develop
git status  # Should show "working tree clean"

# Step 2: Create release branch from develop
git checkout -b release/v1.1.0

# Step 3: View current branch
git branch -a

# Step 4: Bump version numbers (simulating version change)
cat > VERSION.txt << EOF
Application Version Information

Current Version: 1.1.0
Release Date: 2026-02-10
Status: Release Candidate

Previous: 1.0.0
EOF

git add VERSION.txt
git commit -m "Bump version to 1.1.0"

# Step 5: Update CHANGELOG
cat > CHANGELOG.md << EOF
# Changelog

## [1.1.0] - 2026-02-10
### Added
- User authentication module (feature/user-authentication)
- Stripe payment processing (feature/payment-processing)
- Email notification system (feature/email-notifications)

### Fixed
- Various bug fixes during development

### Changed
- Improved API response times
- Enhanced security validation

## [1.0.0] - 2026-02-10
### Added
- Initial project setup
- Basic project structure
- Documentation
EOF

git add CHANGELOG.md
git commit -m "Update CHANGELOG for v1.1.0"

# Step 6: Simulate a release-critical bug fix
cat > release_bug_fix.txt << EOF
Critical Release Bug Fixes

Fixed Issues:
1. Payment endpoint timeout (Release blocker)
2. Email template rendering issue
3. Authentication token refresh bug

Only fixed on release branch!
EOF

git add release_bug_fix.txt
git commit -m "Fix critical bugs found during release testing"

# Step 7: View all commits on release branch
git log release/v1.1.0 --oneline -5

# Step 8: Switch to main and merge release
git checkout main
git status

# Step 9: Merge release branch to main (non-fast-forward)
git merge --no-ff release/v1.1.0 -m "Merge release/v1.1.0 to production"

# Step 10: Create release tag on main
git tag -a v1.1.0 -m "Release version 1.1.0 - Added auth, payments, email notifications"

# Step 11: Verify tag on main
git tag -l -n5
git show v1.1.0

# Step 12: Switch back to develop and merge release
git checkout develop

# Step 13: Merge bug fixes from release back to develop
git merge --no-ff release/v1.1.0 -m "Merge release/v1.1.0 fixes back to develop"

# Step 14: Delete release branch
git branch -d release/v1.1.0

# Step 15: View final state
git log --graph --oneline --all --decorate -15
```

### Expected Output

```
* abc9999 (tag: v1.1.0, main) Merge release/v1.1.0 to production
|\
| * abc8888 Fix critical bugs found during release testing
| * abc7777 Update CHANGELOG for v1.1.0
| * abc6666 Bump version to 1.1.0
|/
* abc5555 (develop) Merge release/v1.1.0 fixes back to develop
|
* (earlier commits)
* abc1234 (tag: v1.0.0) Initial project structure
```

### Files Created

- VERSION.txt
- CHANGELOG.md
- release_bug_fix.txt

### Key Learning Points

- ✅ Release branches allow version bumping without blocking develop
- ✅ Only bug fixes on release branches (no new features!)
- ✅ Main gets the release AND a tag
- ✅ Release branch must merge back to both main AND develop
- ✅ Semantic versioning follows MAJOR.MINOR.PATCH pattern

---

## Scenario 5: Fix Critical Production Bug with Hotfix

**Objective**: Fix a critical security bug in production without waiting for the next release.

**Context**: A security vulnerability is discovered in v1.1.0. Users need an immediate patch (v1.1.1) before the next planned release.

### Step-by-Step Execution

```bash
# Step 1: Verify current state
git checkout main
git status

# Step 2: Create hotfix branch from main (CRITICAL: from main, not develop)
git checkout -b hotfix/security-vulnerability

# Step 3: Create security patch files
cat > hotfix_security.txt << EOF
Security Vulnerability Patch v1.1.1

VULNERABILITY: SQL Injection in user search endpoint
SEVERITY: Critical
CVE: CVE-2026-XXXXX

FIX APPLIED:
- Parameterized all database queries
- Added input validation
- Implemented rate limiting
- Added security logs

Tested against OWASP Top 10
EOF

git add hotfix_security.txt
git commit -m "Fix critical SQL injection vulnerability"

# Step 4: Add security audit results
cat > hotfix_security_audit.txt << EOF
Security Audit Results - Hotfix v1.1.1

Vulnerability Assessment:
✅ SQL Injection - FIXED
✅ XSS Prevention - ENHANCED
✅ CSRF Tokens - VALIDATED
✅ Rate Limiting - IMPLEMENTED

Recommendation: Deploy immediately
EOF

git add hotfix_security_audit.txt
git commit -m "Add security audit results for hotfix"

# Step 5: View hotfix commits
git log hotfix/security-vulnerability --oneline -3

# Step 6: Switch to main and merge hotfix
git checkout main
git merge --no-ff hotfix/security-vulnerability -m "Merge hotfix/security-vulnerability: Critical security patch"

# Step 7: Create patch version tag
git tag -a v1.1.1 -m "Security patch v1.1.1 - Fix SQL injection vulnerability"

# Step 8: Verify patch tag
git tag -l -n5

# Step 9: View main branch with new tag
git log main --oneline -5

# Step 10: Switch to develop and merge hotfix
git checkout develop
git merge --no-ff hotfix/security-vulnerability -m "Merge hotfix/security-vulnerability back to develop"

# Step 11: Delete hotfix branch
git branch -d hotfix/security-vulnerability

# Step 12: View full GitFlow visualization
git log --graph --oneline --all --decorate -20
```

### Expected Output

```
* xyz1111 (tag: v1.1.1, main) Merge hotfix/security-vulnerability: Critical security patch
|\
| * xyz2222 Add security audit results for hotfix
| * xyz3333 Fix critical SQL injection vulnerability
|/
* abc5555 (develop) Merge hotfix/security-vulnerability back to develop
|
* abc9999 (tag: v1.1.0) Merge release/v1.1.0 to production
...
```

### Files Created

- hotfix_security.txt
- hotfix_security_audit.txt

### Key Learning Points

- ✅ Hotfix branches come from `main` (production), never from develop
- ✅ Hotfixes create PATCH version bumps (1.1.0 → 1.1.1)
- ✅ After fix, merge to BOTH main (tagged) AND develop
- ✅ Allows team to work on v1.2.0 features in develop while production gets v1.1.1
- ✅ Hotfix is the ONLY exception to "develop-first" rule

---

## Scenario 6: Handle Merge Conflicts

**Objective**: Experience and resolve merge conflicts in a controlled environment.

**Context**: Two features modify the same file differently, causing a conflict when merging.

### Step-by-Step Execution

```bash
# Step 1: Create two competing features
git checkout develop

# Step 2: Create first feature
git checkout -b feature/api-enhancement-v1

# Step 3: Create API config file
cat > api_config.txt << EOF
API Configuration v1

Server Settings:
- Host: 0.0.0.0
- Port: 3000
- Environment: development

Database:
- Host: localhost
- Port: 5432
- Name: myapp_db

Cache:
- Type: Redis
- Host: localhost
- Port: 6379

Authentication:
- JWT Secret: secret-key-here
- Token Expiry: 24h
EOF

git add api_config.txt
git commit -m "Add API configuration (v1)"

# Step 4: Switch to develop and create second feature
git checkout develop
git checkout -b feature/api-enhancement-v2

# Step 5: Create DIFFERENT version of same file
cat > api_config.txt << EOF
API Configuration v2

Server Settings:
- Host: 127.0.0.1
- Port: 8080
- Environment: production

Database:
- Host: prod-db.example.com
- Port: 5432
- Name: myapp_prod

Cache:
- Type: Memcached
- Host: cache.example.com
- Port: 11211

Authentication:
- JWT Secret: production-secret-key
- Token Expiry: 12h

Rate Limiting:
- Enabled: true
- Requests: 1000 per minute

Logging:
- Level: info
- Format: json
EOF

git add api_config.txt
git commit -m "Add API configuration (v2)"

# Step 6: Merge first feature
git checkout develop
git merge --no-ff feature/api-enhancement-v1 -m "Merge feature/api-enhancement-v1"

# Step 7: Try to merge second feature (WILL CONFLICT)
git merge --no-ff feature/api-enhancement-v2 -m "Merge feature/api-enhancement-v2"

# Step 8: Check status (will show conflict)
git status

# Step 9: View conflicted file
cat api_config.txt

# Step 10: Manually resolve conflict - choose v2 or combine
# Option A: Keep v2 (simpler for this scenario)
cat > api_config.txt << EOF
API Configuration (Combined Best of Both)

Server Settings:
- Host: 0.0.0.0
- Port: 3000
- Environment: production

Database:
- Host: prod-db.example.com
- Port: 5432
- Name: myapp_prod

Cache:
- Type: Redis
- Host: cache.example.com
- Port: 6379

Authentication:
- JWT Secret: production-secret-key
- Token Expiry: 24h

Rate Limiting:
- Enabled: true
- Requests: 1000 per minute

Logging:
- Level: info
- Format: json
EOF

# Step 11: Stage the resolved file
git add api_config.txt

# Step 12: Complete the merge
git commit -m "Resolve conflict: Combine best of both API configurations"

# Step 13: View merge with conflict resolution
git log --graph --oneline --all -8

# Step 14: Delete both feature branches
git branch -d feature/api-enhancement-v1 feature/api-enhancement-v2

# Step 15: View clean state
git log develop --oneline -5
```

### Expected Output (During Conflict)

```
Auto-merging api_config.txt
CONFLICT (add/add): Merge conflict in api_config.txt
Automatic merge failed; fix conflicts and then commit the result.
```

### Expected Output (After Resolution)

```
* con1234 (HEAD -> develop) Resolve conflict: Combine best of both API configurations
|\
| * fea9999 Add API configuration (v2)
* \
*   fea8888 Merge feature/api-enhancement-v1
| * fea7777 Add API configuration (v1)
```

### Key Learning Points

- ✅ Conflicts occur when same file modified differently
- ✅ Git marks conflicts with `<<<<<<<`, `=======`, `>>>>>>>`
- ✅ Resolve by editing the file manually
- ✅ Stage the resolved file with `git add`
- ✅ Complete merge with `git commit`
- ✅ `git merge --abort` if you want to undo

---

## Scenario 7: Release With Hotfix in Flight

**Objective**: Handle the complex situation where a hotfix must be created and merged before a release completes.

**Context**: While preparing v1.2.0 release, a critical bug in v1.1.1 (hotfix) surfaces and must be deployed immediately.

### Step-by-Step Execution

```bash
# Step 1: Simulate - you're in the middle of release preparation
git checkout develop

# Step 2: Create another feature for v1.2.0
git checkout -b feature/advanced-search

cat > feature_search.txt << EOF
Advanced Search Feature

Features:
- Full-text search
- Faceted search
- Search filters
- Search suggestions
- Search analytics

Status: Ready for v1.2.0
EOF

git add feature_search.txt
git commit -m "Add advanced search feature"

git checkout develop
git merge --no-ff feature/advanced-search -m "Merge feature/advanced-search"
git branch -d feature/advanced-search

# Step 3: Start preparing v1.2.0 release
git checkout -b release/v1.2.0

cat > VERSION.txt << EOF
Application Version Information

Current Version: 1.2.0
Release Date: 2026-02-10
Status: Release Candidate

Previous: 1.1.1
EOF

git add VERSION.txt
git commit -m "Bump version to 1.2.0"

# Step 4: INTERRUPT: Critical bug found in v1.1.1 in production!
# Switch to main WITHOUT merging release
git checkout main

# Step 5: Create hotfix from main
git checkout -b hotfix/critical-database-issue

cat > hotfix_db_connection.txt << EOF
Critical Database Connection Bug - v1.1.2

Issue: Database connections not properly closed in v1.1.1
Impact: Connection pool exhaustion after 24 hours
Solution: Implement proper connection cleanup

Files Fixed:
- db_pool.js
- connection_manager.js
- query_executor.js
EOF

git add hotfix_db_connection.txt
git commit -m "Fix critical database connection issue"

# Step 6: Merge hotfix to main
git merge --no-ff hotfix/critical-database-issue -m "Merge hotfix/critical-database-issue"

git tag -a v1.1.2 -m "Hotfix v1.1.2 - Fix database connection pool issue"

# Step 7: Merge hotfix back to develop
git checkout develop
git merge --no-ff hotfix/critical-database-issue -m "Merge hotfix/critical-database-issue back to develop"

# Step 8: Delete hotfix
git branch -d hotfix/critical-database-issue

# Step 9: Now continue with v1.2.0 release (still on develop)
git checkout release/v1.2.0

# Step 10: The release branch might need the hotfix merged in
# (depending on release timing - usually no need if hotfix is after release creation)
# But to be safe, could merge main back to release/v1.2.0:
# git merge --no-ff main -m "Pull in hotfix v1.1.2"

# For now, complete v1.2.0 as planned
cat > CHANGELOG.md << EOF
# Changelog

## [1.2.0] - 2026-02-10
### Added
- Advanced search functionality (feature/advanced-search)

### Fixed
- Database connection pool exhaustion

## [1.1.2] - 2026-02-10 (Hotfix)
### Fixed
- Critical database connection issue

## [1.1.1] - 2026-02-10
### Fixed
- SQL injection vulnerability

## [1.1.0] - 2026-02-10
### Added
- User authentication
- Payment processing
- Email notifications
EOF

git add CHANGELOG.md
git commit -m "Update CHANGELOG for v1.2.0"

# Step 11: Merge release to main
git checkout main
git merge --no-ff release/v1.2.0 -m "Merge release/v1.2.0 to production"

git tag -a v1.2.0 -m "Release v1.2.0 - Enhanced search capabilities"

# Step 12: Merge release back to develop
git checkout develop
git merge --no-ff release/v1.2.0 -m "Merge release/v1.2.0 back to develop"

# Step 13: Delete release branch
git branch -d release/v1.2.0

# Step 14: View complete GitFlow timeline
git log --graph --oneline --all --decorate -25
```

### Expected Output

```
*   xyz4444 (tag: v1.2.0, main) Merge release/v1.2.0 to production
|\
| * xyz3333 Update CHANGELOG for v1.2.0
| * xyz2222 Bump version to 1.2.0
* |
| * xyz5555 (develop) Merge release/v1.2.0 back to develop
|/
*   xyz1111 (tag: v1.1.2) Merge hotfix/critical-database-issue
|\
| * xyz6666 Fix critical database connection issue
|/
* xyz7777 Merge feature/advanced-search
...
```

### Key Learning Points

- ✅ Hotfixes are INDEPENDENT of releases
- ✅ Can create hotfix even while release is in progress
- ✅ Always hotfix from `main`, always release from `develop`
- ✅ Hotfix tagged as PATCH version (1.1.1 → 1.1.2)
- ✅ Release tagged as MINOR version (1.1.0 → 1.2.0)
- ✅ Both follow complete merge flow to main and develop

---

## 📚 Summary Table

| Scenario | Branch From | Branch Name | Merges To | Tag Type |
|----------|-------------|-------------|-----------|----------|
| 1 | N/A | main/develop | N/A | v1.0.0 (initial) |
| 2 | develop | feature/* | develop | None |
| 3 | develop | feature/*, feature/* | develop | None |
| 4 | develop | release/v1.1.0 | main + develop | v1.1.0 |
| 5 | main | hotfix/* | main + develop | v1.1.1 |
| 6 | develop | feature/*, feature/* | develop | None |
| 7 | main (hotfix) + develop (release) | hotfix/*, release/v1.2.0 | main + develop | v1.1.2, v1.2.0 |

---

## 🎓 Checkpoint Verification

After completing all scenarios, verify with:

```bash
# Should show clean working tree
git status

# Should show multiple tags (v1.0.0, v1.1.0, v1.1.1, v1.1.2, v1.2.0)
git tag -l -n5

# Should show complex graph with merges from feature, release, and hotfix branches
git log --graph --oneline --all --decorate -50

# Should show main at latest tag
git log main -1
git log main --decorate

# Should show develop with latest merge
git log develop -1
git log develop --decorate
```

---

**Congratulations!** You've completed all GitFlow scenarios! 🎉

Check [COMMANDS.md](COMMANDS.md) for command reference, and practice these scenarios multiple times until they feel natural!
