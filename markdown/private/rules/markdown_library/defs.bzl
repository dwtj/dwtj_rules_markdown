'''Defines the `markdown_library` Bazel rule.
'''

load(
    '//markdown:private/common/constants.bzl',
    'SUPPORTED_MARKDOWN_FILE_EXTENSIONS',
    'SUPPORTED_MARKDOWNLINT_CONFIG_FILE_EXTENSIONS',
)

MarkdownInfo = provider(
    fields = [
        'direct_source_files',
        'transitive_source_files',
        'markdownlint_config_file',
    ],
)

def _build_transitive_source_files_depset(srcs, deps):
    return depset(
        srcs,
        transitive = [dep[MarkdownInfo].transitive_sources for dep in deps]
    )

def _markdown_library_impl(ctx):
    return MarkdownInfo(
        direct_source_files = depset(ctx.files.srcs),
        transitive_source_files = _build_transitive_source_files_depset(
            srcs = ctx.files.srcs,
            deps = ctx.attr.deps,
        ),
        markdownlint_config_file = ctx.file.markdownlint_config,
    )

markdown_library = rule(
    implementation = _markdown_library_impl,
    attrs = {
        'srcs': attr.label_list(
            allow_empty = False,
            allow_files = SUPPORTED_MARKDOWN_FILE_EXTENSIONS,
            doc = 'A list of Markdown source files to be included.'
        ),
        'deps': attr.label_list(
            providers = [MarkdownInfo],
            doc = 'A list of labels providing `MarkdownInfo` (e.g. `markdown_library` target labels).'
        ),
        'markdownlint_config': attr.label(
            default = None,
            allow_single_file = SUPPORTED_MARKDOWNLINT_CONFIG_FILE_EXTENSIONS,
            doc = 'A `markdownlint` config file to use for linting `srcs`. This overrides a default config file provided from the `markdownlint` toolchain.'
        ),
    },
)
