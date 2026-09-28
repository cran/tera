## -----------------------------------------------------------------------------
#| label: setup
library(tera)


## -----------------------------------------------------------------------------
#| label: hello-world
tera <- Tera$new()

tera$render_string(
  '<p>Hello {{ x }}. This is {{ y }}.</p>',
  x = "world",
  y = "tera"
)


## -----------------------------------------------------------------------------
#| label: directory
template_dir <- system.file("templates", package = "tera")

cat(
  "website",
  list.files(template_dir, recursive = TRUE),
  sep = "\n- "
)


## -----------------------------------------------------------------------------
#| label: glob
#| collapse: true
tera <- Tera$new(file.path(template_dir, "**/*.html"))
tera


## -----------------------------------------------------------------------------
#| label: add-templates
#| collapse: true
# add templates manually from file
tera <- Tera$new()
tera$add_file_templates(
  "base.html" = file.path(template_dir, "base.html"),
  "index.html" = file.path(template_dir, "index.html")
)
tera

# add templates manually from string
tera$add_string_templates(
  img = '<img src="{{ img_src }}">'
)
tera


## -----------------------------------------------------------------------------
#| label: reload
#| collapse: true
example_dir <- file.path(tempdir(), "tera-templates")
dir.create(example_dir)

file.copy(
  from = file.path(template_dir, "base.html"),
  to = file.path(example_dir, "base.html")
)

tera <- Tera$new(file.path(example_dir, "*.html"))
tera

file.copy(
  from = file.path(template_dir, "index.html"),
  to = file.path(example_dir, "index.html")
)

tera$reload()
tera


## -----------------------------------------------------------------------------
#| label: reset-tera-instance
tera <- Tera$new(file.path(template_dir, "**/*.html"))


## -----------------------------------------------------------------------------
#| label: index-template
template_dir |>
  file.path("index.html") |>
  readLines(warn = FALSE) |>
  cat(sep = "\n")


## -----------------------------------------------------------------------------
#| label: render-to-string
string <- tera$render_template(
  "index.html",
  title = "This is my blog",
  p = "Welcome to my awesome homepage.",
  owner = "Blake"
)

cat(string)


## -----------------------------------------------------------------------------
#| label: render-to-file
outfile <- file.path(tempdir(), "rendered-index.html")

tera$render_template(
  "index.html",
  title = "This is my blog",
  p = "Welcome to my awesome homepage.",
  owner = "Blake",
  outfile = outfile
)

cat(readLines(outfile, warn = FALSE), sep = "\n")


## -----------------------------------------------------------------------------
#| label: render-block
string <- tera$render_template(
  "index.html",
  title = "This is my blog",
  p = "Welcome to my awesome homepage.",
  owner = "Blake",
  block = "content"
)

cat(string)


## -----------------------------------------------------------------------------
#| label: render-component
string <- tera$render_component(
  "widget",
  title = "foo",
  body = "<p>This is a widget!</p>"
)

cat(string)


## -----------------------------------------------------------------------------
#| label: render-string-template
string <- tera$render_string(
  '<img src="{{ img_src }}">',
  img_src = "foo/bar.svg"
)

cat(string)


## -----------------------------------------------------------------------------
#| label: inspection
#| collapse: true
tera$templates()
tera$components()
tera$variables("index.html")


## -----------------------------------------------------------------------------
#| label: tera-print
#| collapse: true
tera$print()


## -----------------------------------------------------------------------------
#| label: for-loop
template_dir |>
  file.path("blog", "post.html") |>
  readLines(warn = FALSE) |>
  cat(sep = "\n")


## -----------------------------------------------------------------------------
#| label: render-logic
products <- data.frame(
  name = c("apple", "banana", "orange"),
  price = c(0.25, 0.4, 0.5)
)

string <- tera$render_template(
  "blog/post.html",
  title = "Fruit prices",
  products = products
)

cat(string)


## -----------------------------------------------------------------------------
#| label: autoescape
string <- tera$render_string(
  "{{ html }}",
  html = "<script>alert('Hello World!')</script>"
)

cat(string)


## -----------------------------------------------------------------------------
#| label: autoescape-arg
string <- tera$render_string(
  "{{ html }}",
  html = "<script>alert('Hello World!')</script>",
  autoescape = FALSE
)

cat(string)


## -----------------------------------------------------------------------------
#| label: autoescape-toggle
tera$autoescape_off()
tera$autoescape_on()


## -----------------------------------------------------------------------------
#| label: set-delimiters
alt <- Tera$new()

alt$set_delimiters(
  variable_start = "<<",
  variable_end = ">>"
)

alt$render_string("<< greeting >>, world!", greeting = "Hello")


## -----------------------------------------------------------------------------
#| label: delimiters
alt$delimiters()


## -----------------------------------------------------------------------------
#| label: include
string <- tera$render_string(
  '{%- include "index.html" -%}',
  title = "This is my blog",
  p = "Welcome to my awesome homepage.",
  owner = "Blake"
)

cat(string)


## -----------------------------------------------------------------------------
#| label: base.html
template_dir |>
  file.path("base.html") |>
  readLines(warn = FALSE) |>
  cat(sep = "\n")


## -----------------------------------------------------------------------------
#| label: index.html
template_dir |>
  file.path("index.html") |>
  readLines(warn = FALSE) |>
  cat(sep = "\n")


## -----------------------------------------------------------------------------
#| label: extends
tera <- Tera$new(file.path(template_dir, "**/*.html"))

string <- tera$render_template(
  "index.html",
  title = "This is my blog",
  p = "Welcome to my awesome homepage.",
  owner = "Blake"
)

cat(string)

