"""Defines a repository rule which synthesizes an external repository with a
symlink to a local `markdownlint` binary and some boilerplate to use it as part
of a `markdownlint_toolchain` instance.
"""

load('@dwtj_rules_markdown//markdown:private/common/constants.bzl', 'SUPPORTED_MARKDOWNLINT_CONFIG_FILE_EXTENSIONS')

# This is the name used for the config file *within* this external repository.
_CONFIG_FILE = 'markdownlint_config.json'

# This is the name used for the `markdownlint` executable *within* this external
#  repository.
_MARKDOWNLINT_EXECUTABLE = 'markdownlint'

# This is the name used for the `node` executable *within* this external
#  repository
_NODE_EXECUTABLE = 'node'

def _symlink_which_exec_else_fail(repository_ctx, exec_name, link_to):
    link_from = repository_ctx.which(exec_name)
    if link_from == None:
        fail('Failed to find an executable named `{}` on PATH.'.format(exec_name))

    repository_ctx.symlink(
        link_from,
        link_to,
    )

def _symlink_config_file_if_any(repository_ctx):
    link_from = repository_ctx.attr.config
    if link_from == None:
        # No config file.
        return

    link_to = _CONFIG_FILE

    repository_ctx.symlink(
        link_from,
        link_to,
    )

def _local_markdownlint_external_repository_impl(repository_ctx):
    _symlink_which_exec_else_fail(repository_ctx, "node", _NODE_EXECUTABLE)
    _symlink_which_exec_else_fail(repository_ctx, "markdownlint", _MARKDOWNLINT_EXECUTABLE)
    _symlink_config_file_if_any(repository_ctx)

    # Use a template to create a BUILD file in the root of the respository.
    repository_ctx.template(
        'BUILD',
        repository_ctx.attr._build_file_template,
        substitutions = {
            '{REPOSITORY_NAME}': repository_ctx.name,
            '{NODE_EXECUTABLE}': _NODE_EXECUTABLE,
            '{MARKDOWNLINT_EXECUTABLE}': _MARKDOWNLINT_EXECUTABLE,
            '{CONFIG_FILE}': _CONFIG_FILE,
        },
        executable = False,
    )

    # Use a template to create a `defs.bzl` file in the root of the repository.
    repository_ctx.template(
        'defs.bzl',
        repository_ctx.attr._defs_bzl_file_template,
        substitutions = {
            '{REPOSITORY_NAME}': repository_ctx.name,
        },
        executable = False,
    )

local_markdownlint_repository = repository_rule(
    implementation = _local_markdownlint_external_repository_impl,
    local = True,
    attrs = {
        'config': attr.label(
            # TODO(dwtj): Make this attribute not mandatory and create sensible
            #  default behavior.
            mandatory = True,
            allow_single_file = SUPPORTED_MARKDOWNLINT_CONFIG_FILE_EXTENSIONS,
        ),

        # NOTE(dwtj): The `_build_file_template` and `_defs_bzl_file_template`
        #  are attributes in order to provide these template files from the
        #  `@dwtj_rules_markdown` rules repository.
        #
        #  I tried a more obvious approach first: specify these strings in the
        #  above calls to `repository_ctx.template()`. E.g.,
        #
        #      repository_ctx.template(
        #          'BUILD',
        #          '@dwtj_rules_markdown//.../template.BUILD',
        #          ...
        #      )
        #
        #  But this doesn't work. Specifically, such a string seems to be
        #  interpreted as paths relative to the external repository's root.
        '_build_file_template': attr.label(
            allow_single_file = True,
            default = '@dwtj_rules_markdown//markdown:private/repository_rules/markdownlint/local_markdownlint_repository/TEMPLATE.BUILD',
        ),
        '_defs_bzl_file_template': attr.label(
            allow_single_file = True,
            default = '@dwtj_rules_markdown//markdown:private/repository_rules/markdownlint/local_markdownlint_repository/TEMPLATE.defs.bzl',
        ),
    },
    environ = [
        # This repository is sensitive to changes to `$PATH` because it
        # searches it to find executables (e.g. `markdownlint`).
        "PATH",
    ],
)
