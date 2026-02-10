# 📚 GitFlow Glossary - Learn the Terminology

## Core Concepts

### **Branch**
A parallel line of development in Git. Think of it as a copy of your code where you can make changes independently.

```
main
├── v1.0.0
└── develop
    ├── feature/user-auth
    ├── feature/payment
    └── release/v1.1.0
```

### **Commit**
A snapshot of changes in your code. Each commit has a unique ID (hash), author, timestamp, and message.

```
abc1234 - Initial project setup (main)
def5678 - Add user authentication (feature/user-auth)
ghi9012 - Merge user-auth into develop
```

### **Merge**
Combining changes from one branch into another. GitFlow uses non-fast-forward merges (--no-ff) to preserve branch history.

```
Before Merge:        After Merge:
main: A - B - C      main: A - B - C - M (merge commit)
             \              /
feature: X - Y       feature: X - Y (feature still exists)
```

### **Fast-Forward vs Non-Fast-Forward**

**Fast-Forward Merge** (--ff, default):
- No merge commit created
- Linear history
- Branch history is lost
```
main: A - B     →    main: A - B - C - D
           \              (C and D visible as main directly)
feature: C - D
```

**Non-Fast-Forward Merge** (--no-ff, GitFlow standard):
- Merge commit created (preserves context)
- Shows when features were integrated
- Better for tracking feature completeness
```
main: A - B             →    main: A - B - M (merge commit)
           \                       /       \
feature: C - D          feature: C - D
                        (M shows: "feature merged here")
```

## GitFlow-Specific Terms

### **Hotfix Branch**
A branch created from `main` for critical production bug fixes.
- Pattern: `hotfix/bug-description`
- Merged to: `main` (and tagged) + `develop`
- Lifetime: Short-lived (deleted after merge)

```
main: 1.0.0 - 1.0.1 (hotfix merged)
      \             /
hotfix: security-patch
```

### **Release Branch**
A branch for preparing a release (version bumps, final testing).
- Pattern: `release/v1.1.0`
- Merged to: `main` (tagged) + back to `develop`
- Lifetime: Short-lived
- Allows parallel feature development in `develop`

```
develop: ----feature-X-----[release created]---merge-back---
                            |
release/v1.1.0:             └--version-bump--[tag v1.1.0]
                                             |
main: v1.0.0-------------------------------------------[v1.1.0 tag]
```

### **Feature Branch**
A branch for new feature development.
- Pattern: `feature/username` or `feature/feature-name`
- Created from: `develop`
- Merged back to: `develop`
- Lifetime: Medium-lived (days to weeks)

```
develop: A - B - P (merge commit)
              \   /
feature: C - D - E
```

### **Tag (Release Tag)**
A named reference to a specific commit (usually on `main`). Marks releases.
- Semantic Versioning: `v[MAJOR].[MINOR].[PATCH]`
- Examples: `v1.0.0`, `v1.0.1`, `v1.1.0`, `v2.0.0`
- Purpose: Easy rollback, version identification, deployment reference

```
main: A - B - C (tag: v1.0.0) - D-E-F (tag: v1.1.0)
```

## Git Terminology

### **HEAD**
A pointer to the current branch/commit you're on.

```
Detached HEAD:  HEAD → abc1234 (specific commit)
On a branch:    HEAD → main → abc1234 (main branch tip)
                HEAD → feature → def5678 (feature branch tip)
```

### **Origin**
The default remote repository (usually on GitHub, GitLab, Bitbucket).

```
Local:   your computer
         git push origin main → Remote:   GitHub
         git pull origin main ← 
```

### **Upstream**
The original repository you forked from (in contributions).

```
upstream (original project)
     ↑
     └← pull requests
     
fork (your copy)
     ↓
origin (your GitHub)
     ↓
local (your computer)
```

### **Rebase**
Replaying commits from one branch onto another. Creates linear history.

```
Before Rebase:
main: A - B
           \
feature: C - D

After Rebase:
main: A - B
           \
feature: C' - D' (replayed on top of B)
```

### **Cherry-pick**
Applying a specific commit from one branch to another.

```
Before Cherry-pick:
main: A - B - C
           \
feature: D - E - F (want only E)

After Cherry-pick:
main: A - B - C - E' (E's changes applied here)
```

## DevOps/Engineering Terminology

### **Semantic Versioning (SemVer)**
Version format: `MAJOR.MINOR.PATCH`

- **MAJOR**: Breaking changes (v1.0.0 → v2.0.0)
- **MINOR**: New features, backward compatible (v1.0.0 → v1.1.0)
- **PATCH**: Bug fixes (v1.0.0 → v1.0.1)

Examples:
```
v0.1.0     → Initial development
v1.0.0     → First stable release
v1.0.1     → Hotfix for bug in v1.0.0
v1.1.0     → New features added
v2.0.0     → Major rewrite, not backward compatible
v1.1.0-rc1 → Release candidate (pre-release)
v1.1.0-beta → Beta version (pre-release)
```

### **CI/CD Pipeline**
Automated processes for testing and deploying code.

```
Commit → Test → Build → Deploy
   ↓       ↓      ↓       ↓
LocalPC GitHub Actions Docker Registry Production
```

In GitFlow context:
- **Feature branches**: Run tests only
- **Release branches**: Full testing + version validation
- **Main branch**: Deploy to production

### **Code Review (Pull Request)**
Process where another developer reviews your code before merging.

```
1. Create feature branch
2. Make changes & push
3. Create Pull Request (PR)
4. Team reviews code
5. Approve & merge
```

### **Merge Conflict**
When Git can't automatically merge because both branches modified the same lines.

```
file.txt:
<<<<<<< HEAD (current branch)
This is main's version
=======
This is feature's version
>>>>>>> feature/new-feature

Must choose or combine manually, then commit merge
```

## Command Terminology

### **Clone**
Copy entire repository to your computer.
```bash
git clone https://github.com/user/repo.git
```

### **Fork**
Create your own copy of someone else's repository on GitHub.
```
upstream repo (original)
     ↓
fork (your copy on GitHub)
     ↓
clone (local copy on your computer)
```

### **Push**
Send your local commits to remote repository.
```bash
git push origin main
git push origin feature/my-feature
```

### **Pull**
Get latest changes from remote and merge them locally.
```bash
git pull origin develop
```

### **Fetch**
Download latest changes from remote without merging.
```bash
git fetch origin
```

### **Stash**
Temporarily save changes without committing.
```bash
git stash save "working on feature"
# Do something else...
git stash pop
```

## Summary Quick Reference

| Term | Purpose | Duration | Merges To |
|------|---------|----------|-----------|
| `main` | Production-ready code | Permanent | N/A (merge target) |
| `develop` | Integration branch | Permanent | N/A (merge target) |
| `feature/*` | New features | Days-Weeks | Develop |
| `release/*` | Release prep | Hours-Days | Main + Develop |
| `hotfix/*` | Production fixes | Minutes-Hours | Main + Develop |
| Tag `vX.Y.Z` | Release marker | Permanent | Points to commit on main |

---

**Next Step**: Read [COMMANDS.md](COMMANDS.md) for practical git commands!
