# 🔧 GitFlow Essential Commands

## 📖 Table of Contents
1. [Initial Setup](#initial-setup)
2. [Feature Branch Workflow](#feature-branch-workflow)
3. [Release Branch Workflow](#release-branch-workflow)
4. [Hotfix Workflow](#hotfix-workflow)
5. [Advanced Commands](#advanced-commands)
6. [Viewing History](#viewing-history)

---

## Initial Setup

### Create Local Configuration
```bash
# Set your Git identity (one-time setup)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# View configuration
git config --list
```

### Initialize Repository
```bash
# Create new repo
git init

# Clone existing repo
git clone https://github.com/username/repo-name.git
```

### Create Main and Develop Branches
```bash
# Start on a default branch (usually 'master' or 'main')
git status

# Create develop branch from current location
git branch develop
git branch main

# List all branches
git branch -a

# Verify branches
git branch -v

# Switch to develop
git checkout develop
# or shorter syntax (Git 2.23+)
git switch develop
```

---

## Feature Branch Workflow

### Create Feature Branch
```bash
# Create and switch to feature branch (from develop)
git checkout develop              # Always start from develop
git pull origin develop           # Get latest changes
git checkout -b feature/user-auth # Create feature branch

# Alternative (Git 2.23+)
git switch -c feature/user-auth
```

### Work on Feature
```bash
# Make changes to files
# View status
git status

# Stage changes
git add .
git add src/auth.js              # Stage specific file
git add src/                      # Stage specific directory

# Commit changes
git commit -m "Add user authentication"
git commit -m "Add login endpoint"
git commit -m "Add JWT validation"

# View commits on this feature
git log feature/user-auth -3      # Last 3 commits
git log --oneline feature/user-auth

# View difference from develop
git diff develop...feature/user-auth
```

### Push Feature to Remote
```bash
# First time pushing
git push -u origin feature/user-auth

# Subsequent pushes
git push origin feature/user-auth

# Fetch latest from remote
git fetch origin
```

### Merge Feature into Develop (Non-Fast-Forward)
```bash
# Switch to develop and pull latest
git checkout develop
git pull origin develop

# Merge feature with merge commit
git merge --no-ff feature/user-auth -m "Merge feature/user-auth into develop"

# Push merged develop
git push origin develop

# Delete feature branch locally
git branch -d feature/user-auth

# Delete feature branch on remote
git push origin --delete feature/user-auth

# Clean up all deleted branches
git remote prune origin
```

### View Feature Status
```bash
# List all branches with last commit
git branch -v

# List branches merged into develop
git branch --merged develop

# List branches not merged into develop
git branch --no-merged develop

# Show branches grouped by status
git branch -a --list
```

---

## Release Branch Workflow

### Create Release Branch from Develop
```bash
# Ensure develop is up to date
git checkout develop
git pull origin develop

# Create release branch (from develop)
git checkout -b release/v1.1.0

# Push release branch
git push -u origin release/v1.1.0
```

### Version Bump and Fixes
```bash
# Edit version files (package.json, setup.py, pom.xml, etc.)
# Example: package.json
# "version": "1.1.0"

# Edit CHANGELOG.md
# Add release notes

# Commit version changes
git add .
git commit -m "Bump version to 1.1.0"

# Bug fixes on release branch (only)
git add .
git commit -m "Fix critical bug in payment processing"

# Push changes
git push origin release/v1.1.0
```

### Merge Release to Main
```bash
# Switch to main
git checkout main
git pull origin main

# Merge release branch (non-fast-forward)
git merge --no-ff release/v1.1.0 -m "Merge release v1.1.0"

# Create tag on main
git tag -a v1.1.0 -m "Release version 1.1.0"

# Alternative simple tag (without -a)
git tag v1.1.0

# Push main and tags
git push origin main
git push origin v1.1.0

# Or push all tags
git push origin --tags
```

### Merge Release Back to Develop
```bash
# Switch to develop
git checkout develop
git pull origin develop

# Merge release branch back
git merge --no-ff release/v1.1.0 -m "Merge release v1.1.0 back to develop"

# Push develop
git push origin develop
```

### Delete Release Branch
```bash
# Delete locally
git branch -d release/v1.1.0

# Delete on remote
git push origin --delete release/v1.1.0
```

### View Release Information
```bash
# List all tags
git tag -l

# List tags with details
git tag -l -n5

# Show specific tag details
git show v1.1.0

# Show commits between versions
git log v1.0.0..v1.1.0
git log v1.0.0..v1.1.0 --oneline
```

---

## Hotfix Workflow

### Create Hotfix Branch from Main
```bash
# Ensure you're on main with latest
git checkout main
git pull origin main

# Create hotfix branch from main (IMPORTANT: from main, not develop)
git checkout -b hotfix/security-patch

# Push hotfix branch
git push -u origin hotfix/security-patch
```

### Fix and Test
```bash
# Make critical fixes
git add src/security.js
git commit -m "Fix critical security vulnerability"

# Add additional fixes if needed
git add .
git commit -m "Patch SQL injection vulnerability"

# Push fixes
git push origin hotfix/security-patch
```

### Merge Hotfix to Main
```bash
# Switch to main
git checkout main
git pull origin main

# Merge hotfix (non-fast-forward)
git merge --no-ff hotfix/security-patch -m "Merge hotfix/security-patch"

# Create patch version tag
git tag -a v1.0.1 -m "Security patch release"

# Push main and tag
git push origin main
git push origin v1.0.1
```

### Merge Hotfix Back to Develop
```bash
# Switch to develop
git checkout develop
git pull origin develop

# Merge hotfix
git merge --no-ff hotfix/security-patch -m "Merge hotfix/security-patch back to develop"

# Push develop
git push origin develop
```

### Delete Hotfix Branch
```bash
# Delete locally
git branch -d hotfix/security-patch

# Delete on remote
git push origin --delete hotfix/security-patch
```

---

## Advanced Commands

### Resolve Merge Conflicts
```bash
# During merge, conflicts appear:
# <<<<<<< HEAD
# main version
# =======
# feature version
# >>>>>>> feature/branch-name

# Edit the file, keep desired changes
# Stage the resolved file
git add conflicted-file.js

# Complete the merge
git commit -m "Resolve merge conflict in file.js"

# To abort merge entirely
git merge --abort
```

### Cherry-pick (Apply Specific Commits)
```bash
# Get commit hash you want to copy
git log feature/branch --oneline

# Apply specific commit to current branch
git cherry-pick abc1234

# Cherry-pick multiple commits
git cherry-pick abc1234 def5678 ghi9012

# Cherry-pick range
git cherry-pick abc1234..def5678

# If conflicts during cherry-pick
git cherry-pick --continue  # After resolving
git cherry-pick --abort     # To cancel
```

### Rebase (Advanced - Use Carefully)
```bash
# Rebase current feature on develop
git checkout feature/my-feature
git rebase develop

# Interactive rebase (squash, reorder commits)
git rebase -i HEAD~3        # Last 3 commits
git rebase -i main          # All commits since main

# If conflicts during rebase
git rebase --continue       # After resolving
git rebase --abort          # To cancel

# Force push rebased branch (BE CAREFUL!)
git push origin feature/my-feature --force-with-lease
```

### Stash (Temporary Save)
```bash
# Save work in progress without committing
git stash save "WIP: user authentication"

# List all stashes
git stash list

# Apply most recent stash
git stash pop

# Apply specific stash
git stash apply stash@{0}

# View stash contents
git show stash@{0}

# Delete stash
git stash drop stash@{0}

# Delete all stashes
git stash clear
```

### Amend Last Commit
```bash
# Make additional changes
git add forgotten-file.js

# Amend previous commit
git commit --amend -m "Updated message"

# Amend without changing message
git commit --amend --no-edit

# Push amended commit (force-push)
git push origin branch-name --force-with-lease
```

---

## Viewing History

### Log Commands
```bash
# Simple one-line log
git log --oneline

# Last N commits
git log -n 5
git log -5

# All branches visualization
git log --graph --oneline --all

# Pretty visualization
git log --graph --decorate --oneline --all

# See commits between branches
git log main..develop         # Commits in develop not in main
git log develop..main         # Commits in main not in develop

# See commits by author
git log --author="Your Name"

# See commits with search
git log -S "search-text"      # Search in code changes
git log --grep="pattern"      # Search in commit messages

# See changes in specific file
git log -- filename.js
git log -p -- filename.js     # Show actual changes
```

### Diff Commands
```bash
# Compare branches
git diff main develop

# Compare branches (stats only)
git diff --stat main develop

# Compare specific file
git diff main develop -- src/app.js

# Compare tags
git diff v1.0.0 v1.1.0

# View staged changes
git diff --staged

# View all changes (staged + unstaged)
git diff HEAD
```

### Show Commands
```bash
# Show specific commit
git show abc1234

# Show specific commit in specific file
git show abc1234 -- filename.js

# Show tag details
git show v1.0.0

# Show tag with stat
git show --stat v1.0.0
```

### Blame (Track Code History)
```bash
# See who changed each line
git blame filename.js

# See changes to specific lines
git blame -L10,20 filename.js

# See detailed blame
git blame -l filename.js      # Show full commit hash
```

---

## Quick Reference Cheat Sheet

```bash
# Daily workflow
git status
git add .
git commit -m "message"
git push origin branch

# Feature workflow
git checkout -b feature/name    # Create feature
git commit -m "message"         # Work on it
git push -u origin feature/name # Push
git checkout develop            # Go to develop
git pull origin develop         # Update
git merge --no-ff feature/name  # Merge
git push origin develop         # Push

# Release workflow
git checkout -b release/v1.1.0  # Create release
# Bump version, tag, fix bugs
git merge --no-ff release/v1.1.0 # Merge to main
git tag v1.1.0                  # Tag on main
git merge --no-ff release/v1.1.0 # Merge back to develop

# Hotfix workflow
git checkout -b hotfix/bug-fix  # Create from main
# Fix bug
git merge --no-ff hotfix/bug-fix # Merge to main
git tag v1.0.1                  # Tag on main
git merge --no-ff hotfix/bug-fix # Merge back to develop

# View history
git log --graph --oneline --all
git branch -a -v
git tag -n5
```

---

## Common Mistakes & Recovery

```bash
# Oops! Committed to wrong branch
git reset HEAD~1                # Undo last commit (keep changes)
git checkout -b new-branch      # Create correct branch
git commit -m "message"

# Oops! Pushed to wrong remote
git push origin --force-with-lease  # Only force-push to own branches!

# Oops! Need to undo merge
git merge --abort               # During merge
git reset --hard HEAD~1         # After merge (loses merge)
git revert -m 1 commit-hash     # Create inverse commit (safer)

# Oops! Deleted branch by accident
git reflog                       # Find deleted branch commit
git checkout -b branch-name abc1234

# Oops! Need to see what changed
git diff
git diff --staged
git diffstat
```

---

## Pro Tips

✅ **Always use `--no-ff` for merges** (preserves branch history)
✅ **Write descriptive commit messages** (helps future you!)
✅ **Pull before push** (avoids conflicts)
✅ **Delete merged branches** (keeps repo clean)
✅ **Tag every release** (enables easy rollback)
✅ **Use `--force-with-lease`** instead of `--force` (safer)
✅ **Review before merge** (catch issues early)

---

**Next Step**: Read [SCENARIOS.md](SCENARIOS.md) for real-world practice examples!
