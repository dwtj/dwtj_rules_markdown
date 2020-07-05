'''Provides the implementation for the `markdownlint_toolchain` rule.

Markdown lint toolchain instances are created by writing
`markdownlint_toolchain` rule instances.
'''

MarkdownlintToolchainInfo = provider(
    fields = [
        "markdownlint_executable",
    ],
)

def _markdownlint_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        markdownlint_toolchain_info = MarkdownlintToolchainInfo(
            markdownlint_executable = ctx.file.markdownlint_executable,
        ),
    )
    return [toolchain_info]

markdownlint_toolchain = rule(
    implementation = _markdownlint_toolchain_impl,
    attrs = {
        "markdownlint_executable": attr.label(
            allow_single_file = True,
            mandatory = True,
            executable = True,
            cfg = "host",
        ),
    }
)
