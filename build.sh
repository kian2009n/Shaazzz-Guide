URL="https://docs.google.com/spreadsheets/d/e/2PACX-1vT4u9dg9TRV_VjxMhv4TuXOTRcKUGQz2_vt2eh2-PUn6sC6wEi9_djsKzVLMpK2R63XvIKO94TVjmmZ/pub?gid=1911820389&single=true&output=csv"

curl -Ls $URL -o "problems.csv"

python scripts/csv_to_json.py

python scripts/blog_generator.py

python scripts/nav.py

