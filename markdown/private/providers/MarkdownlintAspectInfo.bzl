'''Defines the `MarkdownlintAspectInfo` provider.
'''

MarkdownlintAspectInfo = provider(
    fields = {
        # Will be `None` if the target can't be or shouldn't be linted.
        'output_file': 'The lint report file produced by `markdownlint`.',
    }
)
