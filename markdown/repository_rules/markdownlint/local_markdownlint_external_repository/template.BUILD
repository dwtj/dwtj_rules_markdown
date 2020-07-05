# This rule instance defines the target with the `MarkdownlintInfo` provider.
# Effectively, it just encapsulates a string which points to the symlink at the
# root of this external repository.
load("@dwtj_rules_markdown//markdown:defs.bzl", "markdownlint_toolchain")
markdownlint_toolchain(
    name = "local_markdownlint_toolchain",
    markdownlint_executable = ":markdownlint",
    config = "{CONFIG_FILE}",
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