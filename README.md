# شازززگاید (Shaazzz Guide)

> 🤖 **AI-Generated**: This documentation was made with AI help. Feel free to edit and improve it :)

Welcome to the Shaazzz-Guide project maintenance documentation. This guide provides comprehensive instructions for contributors and maintainers on how to update and maintain the project effectively.

## 📋 Table of Contents

1. [Project Overview](#-project-overview)
2. [Project Structure](#-project-structure)
3. [Adding Problems to the Problem Sheet](#-adding-problems-to-the-problem-sheet)
4. [Creating Blog Posts](#️-creating-blog-posts)
5. [Update Process](#-update-process)
6. [Configuration Files](#️-configuration-files)
7. [Deployment](#-deployment)
8. [Important Guidelines](#️-important-guidelines)
9. [Contributing](#-contributing)
10. [Support](#-support)

## 🎯 Project Overview

The Shaazzz Guide consists of two main components that work together to create a comprehensive competitive programming resource:

1. **Educational Blog Posts**: Detailed tutorials and explanations for various competitive programming topics
2. **Curated Problem Sheet**: A collection of problems organized by topics and difficulty levels

Each problem in the problem sheet is automatically associated with relevant blog posts through a tag system, creating a seamless learning experience for users.

## 📁 Project Structure

```
Shaazzz-Guide/
├── README.md                 # This documentation
├── problems.csv             # Downloaded problem data (auto-generated)
├── problems.json            # Processed problem data (auto-generated)
├── judges.json              # Judge configurations
├── tags.json                # Topic/tag configurations
├── Posts/                   # Source markdown files for blog posts
│   ├── intro.md
│   ├── implementation.md
│   └── ...
├── Blog/                    # MkDocs configuration and generated content
│   ├── mkdocs.yml
│   ├── docs/               # Generated documentation (auto-generated)
│   └── site/               # Built site (auto-generated)
└── scripts/                # Automation scripts
    ├── csv_to_json.py
    ├── blog_generator.py
    └── ...
```

## 📊 Adding Problems to the Problem Sheet

Problems are managed through a centralized Google Spreadsheet that ensures consistency and collaborative editing.

### 🔗 Access the Problem Sheet

The problems are maintained in this Google Spreadsheet:
**[Shaazzz Guide Problem Sheet](https://docs.google.com/spreadsheets/d/1wvFlQJMeln2OvCurF8qe1GtehI_2411a3jd6rTgKWEs/edit?gid=1911820389#gid=1911820389)**

> **⚠️ Access Required**: Contact one of the project administrators to request edit access to the spreadsheet.

### 📝 Spreadsheet Structure

The spreadsheet contains 5 essential columns:

| Column | Description | Guidelines |
|--------|-------------|------------|
| **Judge** | The platform where the problem is hosted | Use consistent naming (e.g., `cf` not `codeforces`) |
| **Name** | Complete problem title | Copy and paste exactly, preserving case |
| **URL** | Direct link to the problem | Ensure the link is accessible and permanent |
| **TAG** | Problem topic/category | Use existing tags when possible, separate multiple tags with `\|` |
| **Difficulty** | Problem difficulty rating | Base on Codeforces rating scale (800-3500) |

### 🏷️ Tag Guidelines

**🚨 CRITICAL TAGGING RULES:**

1. **Minimize Multiple Tags**: Use single tags whenever possible. A problem should only have multiple tags if it genuinely requires multiple advanced concepts.

2. **Main Topic Focus**: Tag based on the primary algorithmic concept. For example:
   - ✅ A segment tree problem that uses binary search for implementation → Tag: `segment_tree`
   - ❌ Don't tag as: `segment_tree | binary_search`

3. **Audience Considerations**: When using multiple tags for different skill levels (e.g., `binary_search | segment_tree`), ensure the problem has high difficulty to avoid confusing beginners.

### 📈 Difficulty Rating Guidelines

- **Base Scale**: Use Codeforces rating system (800-3500)
- **Independent Assessment**: Don't rely solely on official ratings, especially for older problems
- **Community Input**: Discuss difficulty ratings with other contributors when possible
- **Cross-Platform Consistency**: Rate non-Codeforces problems as if they were Codeforces problems

## ✍️ Creating Blog Posts

### 📂 File Location
All blog posts must be created in the `Posts/` directory as Markdown (`.md`) files.

### 📋 Writing Guidelines

1. **No Title Headers**: Don't include H1 or H2 headers - these are automatically generated
2. **Start with H3**: Begin your content with level 3 headers (`###`)
3. **Markdown Support**: Full Markdown syntax is supported
4. **Material for MkDocs**: You can use [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) features for enhanced formatting

### 📝 Example Structure

```markdown
### یک تاپیک دلخواه

یک سری توضیح

### پیاده‌سازی

```cpp
// کد نمونه
```

## 🔄 Update Process

### Step 1: Update Configuration Files

After creating your blog post, update the `tags.json` file:

```json
{
    "Level1": {
        "your_topic": {
            "path": "your_topic.md",
            "blog_title": "عنوان فارسی موضوع"
        }
    }
}
```

**Important Notes:**
- The key (`your_topic`) must match the tag names used in the problem sheet
- `path` is relative to the `Posts/` directory
- `blog_title` is the Persian title displayed on the website

### Step 2: Prepare Environment and Download Problem Data

Before running the automation scripts, you need to clean up generated directories and download the latest problem data from the Google Spreadsheet.

#### Clean Up Generated Directories

First, remove the automatically generated directories that will be recreated by the scripts:

```bash
# Remove generated directories
rm -rf Blog/docs/ Blog/site/
```

**Why this is necessary:**
- `Blog/docs/` contains the generated documentation files
- `Blog/site/` contains the built static site files  
- These directories must be removed to ensure clean regeneration
- The scripts will recreate these directories with updated content

#### Download Latest Problem Data

Download the most recent problem data from the Google Spreadsheet as a CSV file:

```bash
# Download latest problem data
URL="https://docs.google.com/spreadsheets/d/e/2PACX-1vT4u9dg9TRV_VjxMhv4TuXOTRcKUGQz2_vt2eh2-PUn6sC6wEi9_djsKzVLMpK2R63XvIKO94TVjmmZ/pub?gid=1911820389&single=true&output=csv"
curl -Ls $URL -o "problems.csv"
```

**Important Notes:**
- This command works even if you don't have direct edit access to the Google Sheet
- The URL is a public export link that provides read-only access to the data
- The `-L` flag follows redirects, `-s` makes it silent for cleaner output
- The file will be saved as `problems.csv` in the main directory
- This CSV file will be processed by the `csv_to_json.py` script in the next step

### Step 3: Generate Content

Run the automation scripts from the main directory:

```bash
# Convert CSV to JSON
python scripts/csv_to_json.py

# Generate blog content
python scripts/blog_generator.py
```

**Script Functions:**
- `csv_to_json.py`: Converts the CSV data to a structured JSON format
- `blog_generator.py`: Generates blog posts with embedded problems and updates the complete problem set

### Step 4: Deploy

For administrators with push access:

```bash
cd Blog
mkdocs gh-deploy
```

For contributors:
1. Create a pull request with your changes
2. Wait for administrator review and approval

## ⚙️ Configuration Files

### `judges.json`
Defines all supported online judges and their display properties.

**Structure:**
```json
{
    "judge_key": {
        "name": "Display Name",
        "icon": "judge-iconname",
        "url": "https://judge-website.com/",
        "admonition": {  // Optional
            "type": "warning",
            "title": "Warning Title",
            "content": "Warning message"
        }
    }
}
```

**Adding New Judges:**
1. Add the judge configuration to `judges.json`
2. Create an SVG icon at `Blog/overrides/.icons/judge/iconname.svg`
3. Use consistent naming between the problem sheet and configuration

### `tags.json`
Organizes topics by difficulty levels and maps them to blog posts.

**Structure:**
```json
{
    "Level1": {
        "tag_name": {
            "path": "filename.md",
            "blog_title": "Persian Title"
        }
    },
    "Level2": {},
    ...
}
```

### `problems.json`
**🚨 DO NOT MODIFY MANUALLY** - This file is automatically generated by `csv_to_json.py`.

## 🚀 Deployment

The project uses MkDocs with the Material theme for documentation generation and GitHub Pages for hosting.

### Local Development
```bash
cd Blog
mkdocs serve
```

### Production Deployment
```bash
cd Blog
mkdocs gh-deploy
```

## ⚠️ Important Guidelines

### Navigation Menu
**🚨 NEVER MODIFY** the `nav` section in `mkdocs.yml` - it's automatically generated based on `tags.json`.

### Directory Usage
- ✅ Write posts in `Posts/` directory
- ❌ Never write directly in `Blog/docs/` directory

### File Management
- `Blog/docs/` and `Blog/site/` are automatically generated
- Always remove these directories before regenerating content
- `problems.csv` and `problems.json` are temporary/generated files

### Quality Assurance
1. Test locally before submitting changes
2. Verify all links work correctly
3. Ensure Persian text displays properly
4. Check that problems are correctly associated with topics

## 🤝 Contributing

1. Fork the repository
2. Create your blog posts in `Posts/`(and add problems to the spreadsheet if you want)
3. Update `tags.json` appropriately
4. Follow the update process
5. Submit a pull request with a clear description


---

**Website**: [guide.shaazzz.ir](https://guide.shaazzz.ir)  
