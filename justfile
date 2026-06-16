setup:
    git config core.hooksPath .githooks
    npm install

build:
    npm run build

serve:
    npm run preview

dev:
    npm run dev

test:
    echo "No tests configured yet"

# Add an image to the gallery.
# Usage: just add-gallery ./path/to/img.jpg collection [tag1 tag2 ...]
# Example: just add-gallery ./vaas-02.jpg Vazen draaien kobalt
add-gallery path collection *tags:
    #!/usr/bin/env bash
    set -euo pipefail
    src="{{path}}"
    collection="{{collection}}"
    tags="{{tags}}"
    basename="$(basename "$src")"
    slug="${basename%.*}"
    dest_img="public/images/${basename}"
    dest_md="src/content/gallery/${slug}.md"

    if [ -f "$dest_md" ]; then
        echo "Error: $dest_md already exists — rename the image or edit the existing entry." >&2
        exit 1
    fi

    cp "$src" "$dest_img"

    {
        echo "---"
        echo "title: \"${slug}\""
        echo "description: \"\""
        echo "date: $(date +%Y-%m-%d)"
        echo "image: \"/images/${basename}\""
        echo "collection: \"${collection}\""
        echo "tags:"
        for tag in $tags; do
            echo "  - \"${tag}\""
        done
        echo "sold: false"
        echo "featured: false"
        echo "---"
        echo ""
    } > "$dest_md"

    echo "✓  Image  → ${dest_img}"
    echo "✓  Entry  → ${dest_md}"
    echo ""
    echo "Open ${dest_md} and fill in title and description."
