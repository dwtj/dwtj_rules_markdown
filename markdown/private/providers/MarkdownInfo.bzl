'''Defines the `MarkdownInfo` provider.
'''

MarkdownInfo = provider(
    fields = [
        'direct_source_files',
        'transitive_source_files',
        'markdownlint_config_file',
    ],
)
