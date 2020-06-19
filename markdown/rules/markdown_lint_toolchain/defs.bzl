'''Provides the implementation for the `markdown_lint_toolchain` rule.

Markdown lint toolchain instances are created by writing
`markdown_lint_toolchain` rule instances.
'''

MarkdownLintToolchainInfo = provider(
    fields = [
        "markdown_lint_tool",
    ],
)

def _markdown_lint_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        markdown_lint_tool = MarkdownLintToolchainInfo(
            markdown_lint_tool = ctx.file.markdown_lint_tool,
        ),
    )
    return [toolchain_info]

markdown_lint_toolchain = rule(
    implementation = _markdown_lint_toolchain_impl,
    attrs = {
        "markdown_lint_tool": attr.label(
            allow_single_file = True,
            mandatory = True,
        ),
    }
)
