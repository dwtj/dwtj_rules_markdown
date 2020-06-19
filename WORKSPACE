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
#  the most recent releases provided with `rules_nodejs` as of 2020-06-14.
node_repositories(
    # TODO(dwtj): Figure out whether this `package_json` attribute is needed.
    package_json = ["//third_party/npm:package.json"],
    node_version = "12.13.0",
    yarn_version = "1.22.4",
)

yarn_install(
    name = "npm",
    package_json = "//third_party/npm:package.json",
    yarn_lock = "//third_party/npm:yarn.lock",
)