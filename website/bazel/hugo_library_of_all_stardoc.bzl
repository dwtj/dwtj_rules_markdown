# TODO(dwtj): This file is largely similar to the file
#  `@dwtj_rules_hugo_website//bazel:hugo_library_of_all_stardoc.bzl`. Consider
#  implementing this functionality in a common way to avoid this duplication.
load("@dwtj_rules_hugo//hugo:defs.bzl", "hugo_library")
load("@dwtj_rules_hugo_website//bazel:hugo_import_stardoc.bzl", "hugo_import_stardoc")

_ALL_STARDOC_IMPORTS = {
    # Don't generate docs for providers yet.
    #"@dwtj_rules_markdown//markdown:private/providers/MarkdownlintAspectInfo.bzl": "MarkdownlintAspectInfo",
    #"@dwtj_rules_markdown//markdown:private/providers/MarkdownlintToolchainInfo.bzl": "MarkdownlintToolchainInfo",
    #"@dwtj_rules_markdown//markdown:private/providers/MarkdownInfo.bzl": "MarkdownInfo",
    "@dwtj_rules_markdown//markdown:private/aspects/markdownlint_aspect/defs.bzl": "markdownlint_aspect",
    "@dwtj_rules_markdown//markdown:private/repository_rules/markdownlint/local_markdownlint_repository/defs.bzl": "local_markdownlint_repository",
    "@dwtj_rules_markdown//markdown:private/rules/markdown_library/defs.bzl": "markdown_library",
    "@dwtj_rules_markdown//markdown:private/rules/markdownlint_toolchain/defs.bzl": "markdownlint_toolchain",
}

def _front_matter(title):
    return \
"""+++
title = "{}"
+++
""".format(title)

def hugo_library_of_all_stardoc(name, all_bzl):
    '''Create a `hugo_library` which wraps all of the indicated stardoc content.

    Args:
      name: The name of the created `hugo_library`.
      all_bzl: The label of a `bzl_library` target which includes all bzl deps.
    Returns:
      `None`
    '''

    for (in_file_label, content_name) in _ALL_STARDOC_IMPORTS.items():
        hugo_import_stardoc(
            name = content_name,
            hugo_path = "content/" + content_name + ".md",
            stardoc_input = in_file_label,
            bzl_deps = [all_bzl],
            add_front_matter = _front_matter(content_name),
        )

    all_hugo_imports = _ALL_STARDOC_IMPORTS.values()
    hugo_library(
        name = name,
        deps = all_hugo_imports,
    )
