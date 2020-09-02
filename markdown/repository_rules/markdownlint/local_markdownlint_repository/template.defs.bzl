# This file was generated from a template with the following substitutions:
#
# REPOSITORY_NAME: {REPOSITORY_NAME}

'''This `defs.bzl` file is placed at the root of an external repository created
by a `local_markdownlint_external_repository` instance. Its function is called
to register the toolchain instance synthesized within this external repository.
'''

def register_local_markdownlint_toolchain():
    native.register_toolchains("@{REPOSITORY_NAME}//:toolchain")
