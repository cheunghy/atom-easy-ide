{exec} = require 'child_process'
_ = require 'underscore-plus'
fs = require 'fs'
{packages} = require 'atom'

userPackageJson = atom.getConfigDirPath() + '/package.json'

syncPackageLists = () ->
  exec "/usr/local/bin/apm list --installed --bare", (e, out, err) ->
    if (e)
      atom.notifications.addError("Sync package failed. #{out} #{err}")
    else
      lines = out.split("\n")
        .filter (l) -> l.length > 0
        .map (l) -> l.split('@')
      pkgList = _.inject lines, ((obj, arr) -> obj[arr[0]] = arr[1]; obj), {}
      retval = JSON.parse(fs.readFileSync(userPackageJson, 'utf8'))
      retval.packageDependencies = pkgList
      fs.writeFileSync(userPackageJson, JSON.stringify(retval, null, '  '))
      atom.notifications.addSuccess("Synced packages.")

syncPackageAfterwards = () ->
  atom.packages.onDidLoadPackage(syncPackageLists)
  atom.packages.onDidUnloadPackage(syncPackageLists)

atom.packages.onDidLoadInitialPackages(syncPackageAfterwards)
