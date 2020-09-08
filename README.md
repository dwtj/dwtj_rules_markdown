# Markdown Rules for Bazel

Automatically lint Markdown files in your Bazel workspace with
[`markdownlint`][1] (via [`markdownlint-cli`][2]) when you `bazel build`.

## Setup Summary

Start linting your Markdown source files in a few steps:

1. Use an `http_archive` workspace rule to add this project as an external
workspace.
2. Declare a `markdown_library` with some Markdown source files.
3. Enable the `markdownlint_aspect` in your `.bazelrc`.
4. Use a `local_markdownlint_repository` repository rule to find a copy of
`markdownlint` and wrap it in a toolchain.

See [`examples/use_local_markdownlint`][3] for a simple but complete example.

## Detailed Setup

### Step 1. Add This Project as an External Workspace

Add something like this to your `WORKSPACE` file:

```starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

DWTJ_RULES_MARKDOWN_COMMIT = "5fcac481becb6e57c7240ea42652ad9ddef36181"
DWTJ_RULES_MARKDOWN_SHA256 = "b4250fc7c13b55df27507e8d53da4fab61cfdc7c3f4b6002a8a312796f678a91"

http_archive(
    name = "dwtj_rules_markdown",
    sha256 = DWTJ_RULES_MARKDOWN_SHA256,
    strip_prefix = "dwtj_rules_markdown-{}".format(DWTJ_RULES_MARKDOWN_COMMIT),
    url = "https://github.com/dwtj/dwtj_rules_markdown/archive/{}.zip".format(DWTJ_RULES_MARKDOWN_COMMIT),
)
```

### Step 2. Declare a `markdown_library`

Add something like this to your `BUILD` files:

```starlark
load("@dwtj_rules_markdown//markdown:defs.bzl", "markdown_library")

markdown_library(
    name = "md",
    srcs = [
        "foo.md",
        "bar.md",
    ],
)
```

### Step 3. Enable the `markdownlint_aspect`

Add this to your workspace's `.bazelrc` file:

```bazelrc
build --aspects @dwtj_rules_markdown//markdown:aspects.bzl%markdownlint_aspect
```

### Step 4. Add A Markdown Lint Toolchain

Create a [`markdownlint-cli` config file][4] in JSON format for your toolchain
to use by default. To use `markdownlint-cli`'s default behavior, just write the
empty object to this file. E.g.,

```sh
echo '{}' > .markdownlint.json
```

Add this to your `WORKSPACE` file:

```starlark
load("@dwtj_rules_markdown//markdown:repositories.bzl", "local_markdownlint_repository")

local_markdownlint_repository(
    name = 'local_markdownlint',
    config = "@//:.markdownlint.json",
)

load('@local_markdownlint//:defs.bzl', 'register_local_markdownlint_toolchain')

register_local_markdownlint_toolchain()
```

This will search your system path for a `markdownlint` executable to use.

## Overview of This Project's Modules

- [**`markdown_library`**](/markdown/defs.bzl): This Bazel rule lets you declare
a set of Markdown files to be linted.

- [**`markdownlint_aspect`**](/markdown/defs.bzl): This Bazel aspect is what
actually adds lint actions to the Bazel action graph.

- [**`markdownlint_toolchain`**](/markdown/defs.bzl): This Bazel rule can be
used to declare instances of the `//markdown/toolchains/lint:toolchain_type`
toolchain type. Such a toolchain instance includes the metadata needed to
locate a `markdownlint` binary. (Some background on Bazel toolchains and
toolchain resolution is provided [here][5].)

**TODO(dwtj)**: Keep drafting this section.

## Future Development Opportunities

Markdown files are used in very flexible ways. There isn't one definitive way to
process them in a build system. It may in fact be most common to not process
them at all (or at least leave the job to GitHub).

This has influenced how we designed these rules. In particular, we've chosen
to put processing of markdown files into Bazel aspects; the
`markdown_library` rule does not itself create any build actions.

**TODO(dwtj)**: Keep drafting this section.

---

[1]: https://github.com/DavidAnson/markdownlint
[2]: https://github.com/igorshubovych/markdownlint-cli
[3]: https://github.com/dwtj/dwtj_rules_markdown/tree/main/examples/use_local_markdownlint
[4]: https://github.com/igorshubovych/markdownlint-cli/blob/5d2a7420e4afe22ec6f93c87dc1f23adb42f0241/README.md
[5]: https://docs.bazel.build/versions/3.3.0/toolchains.html
