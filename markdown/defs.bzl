'''This file exports public rule definitions for use by clients.
'''

load('//markdown/rules/markdown_library:defs.bzl', _markdown_library = 'markdown_library')

load('//markdown/aspects/markdownlint_aspect:defs.bzl', _markdownlint_aspect = 'markdownlint_aspect')

markdown_library = _markdown_library

markdownlint_aspect = _markdownlint_aspect
