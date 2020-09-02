'''This file exports public repository rule definitions for use by clients.
'''

load('//markdown/repository_rules/markdownlint/local_markdownlint_repository:defs.bzl', _local_markdownlint_repository = 'local_markdownlint_repository')

local_markdownlint_repository = _local_markdownlint_repository
