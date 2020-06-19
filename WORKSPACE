workspace(name = "dwtj_rules_markdown")

load('@dwtj_rules_markdown//markdown:defs.bzl', 'local_markdownlint_external_repository')

local_markdownlint_external_repository(
    name = 'local_markdownlint',
)

load('@local_markdownlint//:defs.bzl', 'register_local_markdownlint_toolchain')

register_local_markdownlint_toolchain()
