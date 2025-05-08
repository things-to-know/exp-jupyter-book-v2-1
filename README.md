# Experiment \#1 with Jupyter Book v2

TODO

## Requirements

Beyond the obvious requirements of Python and pip, and the package `jupyter-book`,
Node.js is required as well.

## Jupyter Book v2 version

```bash
pip install "jupyter-book==2.0.0a3"
pip freeze > requirements.txt
```

## How-to

### Build and export

```bash
jupyter book build --docx
```

```text
📬 Performing exports:
   myst.yml -> my_project.docx
📖 Built intro.md in 13 ms.
📖 Built myst.yml#project.parts.abstract in 13 ms.
📖 Built myst.yml#project.parts.summary in 12 ms.
📚 Built 3 pages for export (including 2 dependencies) from /[...]/gh-cdd/exp-jupyter-book-v2-1 in 26 ms.
📄 Exported DOCX in 430 ms, copying to my_project.docx
```
