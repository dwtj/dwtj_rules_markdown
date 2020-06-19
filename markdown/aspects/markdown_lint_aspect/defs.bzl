'''Defines the `markdown_lint_aspect` Bazel aspect.

This aspect adds a lint as an action to `markdown` targets. The lint is
performed by the lint tool provided by the selected `markdown_lint_toolchain`.
'''

def _markdown_lint_aspect_impl(target, ctx):
    # TODO(dwtj): Actually create lint actions.
    print(target)
    print(ctx.toolchains['//markdown/toolchains/lint:toolchain_type'])
    if hasattr(ctx.rule.attr, 'srcs'):
        for srcs in ctx.rule.attr.srcs:
            for f in srcs.files.to_list():
                print(f.path)
    return []

markdown_lint_aspect = aspect(
    implementation = _markdown_lint_aspect_impl,
    attr_aspects = ['deps'],
    toolchains = ['@me_dwtj_rules_markdown//markdown/toolchains/lint:toolchain_type'],
)