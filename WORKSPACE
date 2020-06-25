workspace(name = "me_dwtj_rules_markdown")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# CONFIGURE NODE.JS AND NPM TO GET `markdownlint` TOOL ########################

# `markdownlint` is implemented in node.js, so we import `rules_nodejs` to help
#  fetch and run it.
# NOTE(dwtj): This version was choosen because it was the most recent release as
#  of 2020-06-14.
http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = "84abf7ac4234a70924628baa9a73a5a5cbad944c4358cf9abdb4aab29c9a5b77",
    url = "https://github.com/bazelbuild/rules_nodejs/releases/download/1.7.0/rules_nodejs-1.7.0.tar.gz",
)

load(
    "@build_bazel_rules_nodejs//:index.bzl",
    "node_repositories",
    "yarn_install",
)

# NOTE(dwtj): This workspace rule installs Node.js, NPM, and Yarn as external
#  workspaces. However, it does not install NPM dependencies. The package
#  manager still needs to be run to install NPM dependencies. The `yarn_install`
#  rule is used to install dependencies. Some background is provided [here][1].
#
#  [1]: https://bazelbuild.github.io/rules_nodejs/install.html#dependencies
#
# NOTE(dwtj): Node.js and NPM are currently only being used in this project to
#  fetch and run `markdownlint` over Markdown files in this repository.
# NOTE(dwtj): These versions of Node.js and Yarn were choosen because they were
#  the most latest LTS releases of Node.JS as of 2020-06-20.
# NOTE(dwtj): See [here] for background on using this rule.
node_repositories(
    # TODO(dwtj): Figure out whether this `package_json` attribute is needed.
    package_json = ["//third_party/npm:package.json"],
    node_version = "12.18.1",
    node_repositories = {
        "12.18.1-linux_amd64": ("node-v12.18.1-linux-x64.tar.gz", "node-v12.18.1-linux-x64", "b89a0d497674f388705c877ad4f57766695cfe26ea6c6c9d3ad6ff98827edbfe"),
        "12.18.1-darwin_amd64": ("node-v12.18.1-darwin-x64.tar.gz", "node-v12.18.1-darwin-x64", "80e1d644fe78838da47cd16de234b612c20e06ffe14447125db9622e381ed1ba"),
        "12.18.1-windows_amd64": ("node-v12.18.1-win-x64.zip", "node-v12.18.1-win-x64", "93039ebfc7c5bfad168b015f77667757925070fff3ae84c3eb73348b3123a82a"),
    },
    yarn_version = "1.22.4",
)

yarn_install(
    name = "npm",
    package_json = "//third_party/npm:package.json",
    yarn_lock = "//third_party/npm:yarn.lock",
)

load("//bazel/local_tool_repository_rule:defs.bzl", "local_tool")

local_tool(
    name = "local_ldd",
    tool_name = "ldd",
)
