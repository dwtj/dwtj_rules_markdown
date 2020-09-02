'''This file exports public toolchain rule definitions for use by clients.
'''

load('//markdown:private/rules/markdownlint_toolchain/defs.bzl', _markdownlint_toolchain = 'markdownlint_toolchain')

markdownlint_toolchain = _markdownlint_toolchain
