load("@dwtj_rules_hugo//hugo:defs.bzl", "hugo_website")
load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("bazel/hugo_library_of_all_stardoc.bzl", "hugo_library_of_all_stardoc")
load("@rules_pkg//:pkg.bzl", "pkg_tar")

alias(
    name = "site",
    actual = ":gh_pages_website",
)

pkg_tar(
    name = "gh_pages",
    srcs = [":gh_pages_website"],
    strip_prefix = "gh_pages_website",
    package_dir = "docs",
)

hugo_website(
    name = "gh_pages_website",
    srcs = [
        "config.toml",
    ],
    deps = [
        ":all_stardoc",
        "@dwtj_rules_hugo_website//:gh_pages_theme",
    ],
)

bzl_library(
    name = "all_bzl",
    srcs = ["@dwtj_rules_markdown//markdown:all_bzl_files_in_project"]
)

hugo_library_of_all_stardoc(
    name = "all_stardoc",
    all_bzl = ":all_bzl",
)
