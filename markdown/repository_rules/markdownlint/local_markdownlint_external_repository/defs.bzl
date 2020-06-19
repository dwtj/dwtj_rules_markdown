"""Defines a repository rule which synthesizes an external repository with a
symlink to a local `markdownlint` binary and some boilerplate to use it as part
of a `markdownlint_toolchain` instance.
"""
_BUILD_FILE_CONTENTS = """
# This rule instance defines the target with the `MarkdownlintInfo` provider.
# Effectively, it just encapsulates a string which points to the symlink at the
# root of this external repository.
load("@dwtj_rules_markdown//markdown:defs.bzl", "markdownlint_toolchain")
markdownlint_toolchain(
    name = "local_markdownlint_toolchain",
    markdownlint_executable = ":markdownlint",
)

# This rule instance declares that the rule `:local_markdownlint_toolchain` is a
# toolchain of type `markdownlint` and that it can be executed on the host.
# (Here we assume that because this `markdownlint` tool was found locally it can
# be executed locally.)
toolchain(
    name = "toolchain",
    # TODO(dwtj): Figure out how to say that this can be executed on the host.
    toolchain = ":local_markdownlint_toolchain",
    toolchain_type = "@dwtj_rules_markdown//markdown/toolchains/markdownlint:toolchain_type",
    visibility = ["//visibility:public"],
)
"""

_DEFS_FILE_CONTENTS = """
def register_local_markdownlint_toolchain():
    native.register_toolchains("@local_markdownlint//:toolchain")
"""

def _local_markdownlint_external_repository_impl(repository_ctx):
    link_from = repository_ctx.which('markdownlint')
    link_to = 'markdownlint'
    repository_ctx.symlink(
        link_from,
        link_to,
    )

    # Create a BUILD file in the root of the external respository from str.
    repository_ctx.file(
        "BUILD",
        _BUILD_FILE_CONTENTS,
        executable = False,
    )

    # Create a `defs.bzl` file in the root of the external repository from str.
    repository_ctx.file(
        "defs.bzl",
        _DEFS_FILE_CONTENTS,
        executable = False,
    )

local_markdownlint_external_repository = repository_rule(
    implementation = _local_markdownlint_external_repository_impl,
    local = True,
)