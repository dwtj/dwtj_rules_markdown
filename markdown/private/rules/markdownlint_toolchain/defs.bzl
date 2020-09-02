'''Provides the implementation for the `markdownlint_toolchain` rule.

Markdown lint toolchain instances are created by writing
`markdownlint_toolchain` rule instances.
'''

load('//markdown:private/common/constants.bzl', 'SUPPORTED_MARKDOWNLINT_CONFIG_FILE_EXTENSIONS')

MarkdownlintToolchainInfo = provider(
    fields = [
        "node_executable",
        "markdownlint_executable",
        "config_file",
    ],
)

def _markdownlint_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        markdownlint_toolchain_info = MarkdownlintToolchainInfo(
            node_executable = ctx.file.node_executable,
            markdownlint_executable = ctx.file.markdownlint_executable,
            config_file = ctx.file.config,
        ),
    )
    return [toolchain_info]

markdownlint_toolchain = rule(
    implementation = _markdownlint_toolchain_impl,
    attrs = {
        "node_executable": attr.label(
            allow_single_file = True,
            mandatory = True,
            executable = True,
            cfg = "host",
        ),
        "markdownlint_executable": attr.label(
            allow_single_file = True,
            mandatory = True,
            executable = True,
            cfg = "host",
        ),
        "config": attr.label(
            allow_single_file = SUPPORTED_MARKDOWNLINT_CONFIG_FILE_EXTENSIONS,
            mandatory = False,
            default = None,
        ),
    }
)
