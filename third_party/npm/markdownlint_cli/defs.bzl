'''This package defines the macro `markdownlint_binary` and some helper
constants.

This macro builds the Node.js tool `markdownlint-cli` into a standalone
executable binary. A [target][1] Node.js version, platform, and architecture can
be chosen for the executable.

[1]: https://www.npmjs.com/package/pkg#targets
'''

load('@build_bazel_rules_nodejs//:index.bzl', 'npm_package_bin')

KNOWN_TARGET_NODE_VERSIONS = [
    '10',
    '11',
    '12',
    'latest'
]

KNOWN_TARGET_PLATFORMS = [
    'freebsd',
    'linux',   # GUESS(dwtj): This means Linux using the glibc C runtime.
    'alpine',  # GUESS(dwtj): This means Linux using the musl C runtime.
    'macos',
    'win',
]

KNOWN_TARGET_ARCHS = [
    'x64',
    'x86',
    'armv6',
    'armv7',
]

def markdownlint_binary(
    name,
    target_node_version,
    target_platform,
    target_arch,
    output = 'markdownlint'):

    # TODO(dwtj): Check that each given target argument is known.

    target = 'node{}-{}-{}'.format(
        target_node_version,
        target_platform,
        target_arch
    )

    # NOTE(dwtj): The naming of "package", "bin" and "pkg" is a bit confusing.
    #  Here's some clarification. This rule kind, `npm_package_bin`, executes
    #  a Node program during the the Bazel build phase. It can execute a Node
    #  programs declared as a "bin" in an NPM package's `package.json` file.
    #  Somewhat confusingly, the particular Node program run by this rule
    #  instance is named `pkg`, and it is defined in the NPM package `pkg`.
    npm_package_bin(
        name = name,
        tool = "@npm//pkg/bin:pkg",
        data = [
            # We are compiling `markdown-cli` to a binary.
            "@npm//markdownlint-cli",
            # Our compiler, `pkg`, calls `ldd` to find out if the host is Alpine
            #  linux. But, bazel doesn't include `ldd` in the build action's
            #  sandbox.
            "@local_ldd//:ldd",
        ],
        outs = [output],
        args = [
            '--target', target,
            '--output', output,
            'external/npm/markdownlint_cli/bin'
            # TODO(dwtj): Figure out the path to the `package.json` of 
            #  `markdownlint-cli`.
        ],
    )
