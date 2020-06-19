#!/bin/sh -

bazel build ... --aspects @me_dwtj_rules_markdown//markdown:defs.bzl%markdown_lint_aspect --output_groups=markdownlint_logs
