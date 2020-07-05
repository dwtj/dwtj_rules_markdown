load("//markdown:defs.bzl", "markdown_library")

markdown_library(
    name = "good_markdown",
    srcs = [
        "a_good_markdown_file.md",
    ],
)

markdown_library(
    name = "nonstandard_markdown",
    srcs = [
        "a_nonstandard_markdown_file.md",
    ],
    markdownlint_config = "a_nonstandard_markdownlint_config.json",
)
