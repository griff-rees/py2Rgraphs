.onLoad <- function(libname, pkgname) {
  reticulate::configure_environment(pkgname, force = TRUE)
  if(length(reticulate::virtualenv_list()) == 0) {
    # TODO ask the user
    message("No Python environment found. Creating one at root: ", 
            reticulate::virtualenv_root())
    v <- reticulate::virtualenv_create()
    # DO NOT feel good about this even with the message
    message("Setting Python environment to: ", v)
    Sys.setenv(RETICULATE_PYTHON_ENV=v)
  } else {
    
  }
  # TODO again we should ask the user
  install_dependencies()
  networkx <<- reticulate::import("networkx", delay_load = TRUE)
  pandas <<- reticulate::import("pandas", delay_load = TRUE)
  netxio <<- reticulate::import_from_path(
    "networkxio",
    system.file("python", package = "py2Rgraphs", mustWork = TRUE)
  )
}
