# Copilot Instructions for AI Coding Agents

## Project Overview
This codebase is a simple static website located in the `PROJETO` directory, containing two HTML files: `index.html` (main page) and `about.html` (about page). There are no scripts, build tools, or external dependencies present.

## Architecture & Structure
- **Single-page HTML files**: Each page is a standalone HTML document. No shared components or templating systems are used.
- **No CSS/JS detected**: Styling and interactivity are either inline or absent. If adding styles or scripts, create new files in `PROJETO/` and link them in the HTML.
- **Navigation**: If implementing navigation, use standard `<a href="...">` links between pages.

## Developer Workflows
- **No build or test steps**: Changes to HTML files are immediately reflected. No compilation or testing required.
- **Previewing**: Open HTML files directly in a browser to view changes. No local server setup is needed.

## Project Conventions
- **File naming**: Use lowercase, descriptive names for new HTML, CSS, or JS files (e.g., `contact.html`, `styles.css`).
- **Directory structure**: Place all website files in the `PROJETO/` folder. Do not create subdirectories unless the project expands.
- **Content updates**: Edit HTML files directly. For new pages, copy the structure of `index.html` as a starting point.

## Integration Points
- **External resources**: If linking to external CSS/JS, use CDN links in the `<head>` section.
- **No backend**: This is a purely static site. Do not add server-side code unless requirements change.

## Examples
- To add a new page:
  1. Create `PROJETO/newpage.html`.
  2. Copy the basic structure from `index.html`.
  3. Add navigation links in all pages as needed.
- To add styles:
  1. Create `PROJETO/styles.css`.
  2. Link it in each HTML file: `<link rel="stylesheet" href="styles.css">`.

## Key Files
- `PROJETO/index.html`: Main landing page.
- `PROJETO/about.html`: About page.

---

If you discover new conventions or workflows, update this file to keep instructions current.
