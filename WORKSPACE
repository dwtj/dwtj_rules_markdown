workspace(name = "dwtj_rules_markdown")

load('@dwtj_rules_markdown//markdown:repositories.bzl', 'local_markdownlint_repository')

local_markdownlint_repository(
    name = 'local_markdownlint',
    config = '//:.markdownlint.json',
)

load('@local_markdownlint//:defs.bzl', 'register_local_markdownlint_toolchain')

register_local_markdownlint_toolchain()
