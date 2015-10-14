##### atom-easy-ide

## atom-easy-ide is a self-documenting atom configuration, it aims easy to
## use and cross platform.

aide = window.aide = {}

#### Setup package management (syncing)

require './conf/package-sync'

#### Setup directory structure

aide.confDir = atom.getConfigDirPath() + '/conf'
aide.etcDir = atom.getConfigDirPath() + '/etc'
