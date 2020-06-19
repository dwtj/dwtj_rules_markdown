'''Defines the `markdown_library` Bazel rule.
'''

MarkdownInfo = provider(
    fields = [
        'transitive_sources',
    ],
)

def _build_transitive_depset(srcs, deps):
    return depset(
        srcs,
        transitive = [dep[MarkdownInfo].transitive_sources for dep in deps]
    )

def _markdown_library_impl(ctx):
    return MarkdownInfo(
        transitive_sources = _build_transitive_depset(
            srcs = ctx.files.srcs,
            deps = ctx.attr.deps,
        ),
    )

markdown_library = rule(
    implementation = _markdown_library_impl,
    attrs = {
        'srcs': attr.label_list(
            allow_empty = False,
            allow_files = ['.md', '.markdown'],
            doc = 'A list of Markdown source files to be included.'
        ),
        'deps': attr.label_list(
            providers = [MarkdownInfo],
            doc = 'A list of labels providing `MarkdownInfo`. Usually, this is a list of names of `markdown_library` instances.'
        )
    },
)
