bazel build --aspects @dwtj_rules_markdown//markdown:defs.bzl%markdownlint_aspect tests/smoke_test:markdown --output_groups=markdownlint_logs 
