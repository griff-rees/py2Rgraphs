.onLoad <- function(libname, pkgname) {
  reticulate::configure_environment(pkgname, force = TRUE)
  install_dependencies()
  networkx <<- reticulate::import("networkx", delay_load = TRUE)
  pandas <<- reticulate::import("pandas", delay_load = TRUE)
  netxio <<- reticulate::import_from_path(
    "networkxio",
    system.file("python", package = "py2Rgraphs", mustWork = TRUE)
  )
}
