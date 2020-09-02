'''Defines the `MarkdownlintToolchainInfo` provider.
'''

MarkdownlintToolchainInfo = provider(
    fields = [
        "node_executable",
        "markdownlint_executable",
        "config_file",
    ],
)
