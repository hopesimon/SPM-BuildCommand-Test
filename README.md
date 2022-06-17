This repository illustrates how Swift Package Plugins do not respect the `inputFiles` array when built from the Xcode IDE.

If you run:
```bash
pushd TestProject && swift package clean && swift build && swift build && popd
```
The output
```
Generated <path/to/repository>/TestPluginProject/PluginProject/.build/plugins/outputs/pluginproject/PluginProject/TestPlugin/GeneratedFile.swift
```
is printed once because the file was, correctly, only generated once. It should not be re-generated unless its `inputFiles` detect modifications.

If you run:
```bash
pushd TestProject && swift package clean && swift build && echo "Editing the input..." > ../PluginProject/Metadata/generate_if_modified.txt && swift build && popd
```
The output
```
Generated <path/to/repository>/TestPluginProject/PluginProject/.build/plugins/outputs/pluginproject/PluginProject/TestPlugin/GeneratedFile.swift
```
is printed twice because the file was, correctly, generated the second time due to a change in `inputFiles`.

However, when you open this project in Xcode
```bash
xed TestProject/Package.swift
```
and try to run or build the executable from within Xcode, the build logs will always include the output
```
Generated <path/to/repository>/TestPluginProject/PluginProject/.build/plugins/outputs/pluginproject/PluginProject/TestPlugin/GeneratedFile.swift
```
because the file will always be generated. This does not respect the fact that the files listed in `inputFiles` were not modified.
