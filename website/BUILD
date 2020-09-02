load("@dwtj_rules_hugo//hugo:defs.bzl", "hugo_website")

alias(
    name = "site",
    actual = ":gh_pages",
)

hugo_website(
    name = "gh_pages",
    srcs = [
        "config.toml",
        "content/some_content.md",
    ]
)
