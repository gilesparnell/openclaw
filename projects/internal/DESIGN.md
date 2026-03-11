# Config Management Design for Mission Control

*Design proposal for programmatic config file editing through Mission Control*

---

## 🎯 Goal

Enable Gilo to view, edit, and manage all config files (SOULs, sources, goals, etc.) through Mission Control UI while keeping:
- Human-readable markdown for direct editing
- Machine-parseable structure for programmatic updates
- Git history for audit trail
- Validation to prevent corruption

---

## 📁 Proposed File Structure

### Pattern: Markdown + YAML Frontmatter

Every config file follows this pattern:

```markdown
---
# YAML frontmatter: machine-editable metadata
id: soul-garion
version: 1.2.0
lastModified: 2026-02-20T04:18:00+11:00
modifiedBy: mission-control
schema: soul-v1
---

# Human-readable content below
# Can include markdown tables, lists, freeform text
```

### Directory Structure

```
workspace/
├── config/                    # Core configuration
│   ├── agents/               # Agent SOULs
│   │   ├── garion.md
│   │   ├── silk.md
│   │   ├── barak.md
│   │   └── polgara.md
│   ├── sources/              # Daily scan sources
│   │   ├── openclaw.md
│   │   ├── competitors.md
│   │   └── industry.md
│   ├── goals/                # Goal tracking
│   │   ├── awe2m8-mrr.md
│   │   ├── product-launch.md
│   │   └── learning.md
│   └── system/               # System settings
│       ├── heartbeat.md
│       ├── cron-jobs.md
│       └── integrations.md
├── memory/                   # Session memory (auto-generated)
│   ├── 2026-02-20.md
│   └── learning-*.md
├── SOUL.md                   # Master SOUL (synced from config/agents/garion.md)
├── GOALS.md                  # Aggregated goals view
├── DAILY-SOURCES.md          # Aggregated sources view
└── MEMORY.md                 # Curated long-term memory
```

---

## 🔧 Mission Control Integration

### 1. Config API Layer

Create `config-api.ts` in Mission Control:

```typescript
interface ConfigFile<T> {
  // Frontmatter (machine-editable)
  meta: {
    id: string;
    version: string;
    lastModified: string;
    modifiedBy: 'mission-control' | 'user' | 'agent';
    schema: string;
  };
  // Content sections (human + machine readable)
  sections: ConfigSection[];
  // Raw markdown for editing
  raw: string;
}

interface ConfigSection {
  id: string;           // machine identifier
  title: string;        // display title
  type: 'table' | 'list' | 'text' | 'code' | 'json';
  editable: boolean;    // can Mission Control edit this?
  content: any;         // parsed content
  lines: [number, number]; // line numbers in file
}
```

### 2. Operations

```typescript
class ConfigManager {
  // Read config with structured access
  async get<T>(path: string): Promise<ConfigFile<T>>;
  
  // Update specific section
  async updateSection(
    path: string, 
    sectionId: string, 
    content: any
  ): Promise<void>;
  
  // Add new entry to table/list
  async appendEntry(
    path: string,
    sectionId: string,
    entry: Record<string, any>
  ): Promise<void>;
  
  // Full text edit (for rich text fields)
  async editRaw(
    path: string,
    newContent: string
  ): Promise<void>;
  
  // Validate before save
  async validate(path: string, content: string): Promise<ValidationResult>;
  
  // Commit changes
  async commit(
    path: string,
    message: string,
    author: 'mission-control' | 'user' | 'agent'
  ): Promise<void>;
}
```

### 3. UI Components

**Table Editor** (for sources, accounts, competitors):
```
┌─────────────────────────────────────────────┐
│ X/Twitter Accounts                    [+Add] │
├──────────────┬──────────────┬───────────────┤
│ Handle       │ Focus        │ Priority  [✏️]│
├──────────────┼──────────────┼───────────────┤
│ @openclaw    │ Official     │ 🔴 High   [🗑️]│
│ @tracypholmes│ Creator      │ 🔴 High   [🗑️]│
└──────────────┴──────────────┴───────────────┘
```

**Markdown Editor** (for SOUL content, goals):
```
┌─────────────────────────────────────────────┐
│ SOUL.md - Garion                      [Save] │
├─────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────┐  │
│ │ ## Core Truths                          │  │
│ │                                         │  │
│ │ Be genuinely helpful...                 │  │
│ │                                         │  │
│ └─────────────────────────────────────────┘  │
│                                              │
│ [Preview] [History] [Validate]               │
└─────────────────────────────────────────────┘
```

**JSON/YAML Editor** (for structured configs):
```
┌─────────────────────────────────────────────┐
│ Cron Job Configuration                [Save] │
├─────────────────────────────────────────────┤
│ {
│   "schedule": "0 7 * * *",
│   "timezone": "Australia/Sydney",
│   ...
│ }
└─────────────────────────────────────────────┘
```

---

## 📝 Example: Refactored DAILY-SOURCES.md

```markdown
---
id: daily-sources
version: 1.0.0
lastModified: 2026-02-20T04:18:00+11:00
modifiedBy: garion
schema: sources-v1
categories:
  - openclaw
  - competitors
  - industry
---

# Daily Scan Sources

Key websites, accounts, and communities to monitor daily.

<!-- section:id=openclaw-official type=table editable=true -->
## 🦞 OpenClaw Official

| Source | URL | What to Watch | Active |
|--------|-----|---------------|--------|
| Official Blog | https://openclaw.ai/blog | Product updates | ✅ |
| Documentation | https://docs.openclaw.ai | Changelog | ✅ |
| GitHub | https://github.com/openclaw/openclaw | Releases | ✅ |
<!-- endsection -->

<!-- section:id=x-accounts type=table editable=true -->
## 📱 X/Twitter Accounts

| Handle | Focus | Priority | Last Checked |
|--------|-------|----------|--------------|
| @openclaw | Official | 🔴 High | 2026-02-20 |
| @tracypholmes | Creator | 🔴 High | 2026-02-20 |
<!-- endsection -->

<!-- section:id=notes type=text editable=true -->
## 📝 Notes

Add observations here...
<!-- endsection -->
```

---

## 🔒 Safety & Validation

### Schema Validation

Each config type has a JSON Schema:

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "id": "sources-v1",
  "type": "object",
  "properties": {
    "meta": {
      "type": "object",
      "required": ["id", "version", "schema"]
    },
    "sections": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "id": { "type": "string" },
          "type": { "enum": ["table", "list", "text"] },
          "editable": { "type": "boolean" }
        }
      }
    }
  }
}
```

### Git Safety

```typescript
async function safeUpdate(path: string, changes: Change[]) {
  // 1. Pull latest
  await git.pull();
  
  // 2. Validate
  const validation = await validate(path, changes);
  if (!validation.valid) {
    throw new ValidationError(validation.errors);
  }
  
  // 3. Apply changes
  await applyChanges(path, changes);
  
  // 4. Test parse
  await parseConfig(path);
  
  // 5. Commit
  await git.add(path);
  await git.commit(`Update ${path} via Mission Control`);
  await git.push();
  
  // 6. Notify agent
  await notifyAgent('config-updated', { path, changes });
}
```

---

## 🔄 Sync Strategy

### Option A: Source of Truth = Files (Recommended)

- Files in `workspace/config/` are source of truth
- Mission Control reads/writes directly
- Git provides history and backup
- Agents reload on file change

### Option B: Database + Files

- Mission Control edits database
- Background job syncs to files
- Files are backup/export format

**Recommendation:** Option A — simpler, no sync complexity, git-native

---

## 🚀 Implementation Phases

### Phase 1: Foundation (Now)
- [ ] Refactor existing configs to frontmatter format
- [ ] Create `config/agents/`, `config/sources/` structure
- [ ] Build parser for markdown + frontmatter
- [ ] Add validation schemas

### Phase 2: API (Week 2)
- [ ] Build ConfigManager class
- [ ] Git integration (commit on change)
- [ ] REST API endpoints for CRUD

### Phase 3: UI (Week 3-4)
- [ ] Table editor component
- [ ] Markdown editor with preview
- [ ] SOUL editor with live preview
- [ ] Config browser (file tree view)

### Phase 4: Advanced (Week 5+)
- [ ] Config templates (new agent wizard)
- [ ] Version history / diff view
- [ ] Batch edits
- [ ] Import/export

---

## 📋 Migration Plan

1. **Create new structure** alongside existing files
2. **Migrate content** with validation
3. **Update agents** to read from new locations
4. **Deprecate old files** (keep for 1 week)
5. **Remove old files** once confirmed working

---

## 🎨 Design Principles

1. **Human-first**: Files remain editable in any text editor
2. **Git-native**: Every change is tracked
3. **Fail-safe**: Validation prevents corruption
4. **Flexible**: Supports tables, text, code, JSON
5. **Discoverable**: Clear structure, good comments

---

*Next step: Approve design, then implement Phase 1 (refactor existing configs)*
