'''The `pkg` Node.js tool (which is used to compile `markdownlint-cli`), uses
`lld`. This repository rule is used to make it available within a Bazel action.
'''

def _local_tool_impl(repository_ctx):
    tool_name = repository_ctx.attr.tool_name
    link_from = repository_ctx.which(tool_name)
    link_to = tool_name
    repository_ctx.symlink(
        link_from,
        link_to,
    )
    # Create a BUILD file in the root of the external respository from template.
    build_file_contents = """
exports_files(
    ["{}"],
    visibility = ["//visibility:public"],
)
"""
    build_file_contents = build_file_contents.format(tool_name)

    repository_ctx.file(
        "BUILD",
        build_file_contents,
        executable = False,
    )

local_tool = repository_rule(
    implementation = _local_tool_impl,
    attrs = {
        "tool_name": attr.string(
            mandatory = True
        ),
    },
    local = True,
)