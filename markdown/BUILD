exports_files(
    # NOTE(dwtj): We export all `bzl` files in this package so that the website
    #  can wrap these files in `bzl_library` targets and pass them to `stardoc`.
    #  We don't want to declare `bzl_library` targets and `stardoc` targets in
    #  this package, because then all users of these rules would also depend
    #  upon the `bazel-skylib` and `stardoc` external repositories (and thus
    #  need to configure their Bazel workspace to include these dependencies).
    glob([
        "**/*.bzl",
    ]),
    # TODO(dwtj): These files are probably only needed for the website. Can we
    #  make visibility narrower even though the website is in an external
    #  repository?
    visibility = ["//visibility:public"],
)

filegroup(
    name = "all_bzl_files_in_project",
    srcs = glob(["**/*.bzl"]),
    # TODO(dwtj): These files are probably only needed for the website. Can we
    #  make visibility narrower even though the website is in an external
    #  repository?
    visibility = ["//visibility:public"]
)
