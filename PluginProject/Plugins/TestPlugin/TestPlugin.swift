//
//  TestPlugin.swift
//

import Foundation
import PackagePlugin

@main
struct TestPlugin: BuildToolPlugin {
    func createBuildCommands(
        context: PluginContext,
        target: Target
    ) async throws -> [Command] {
        let executablePath = context.package.directory
            .appending(subpath: "Scripts")
            .appending("generate")

        let outputPath = context.pluginWorkDirectory
            .appending("GeneratedFile.swift")

        return [
            .buildCommand(
                displayName: "Generating GeneratedFile.swift",
                executable: executablePath,
                arguments: [
                    outputPath.string
                ],
                inputFiles: [
                    context.package.directory
                        .appending(subpath: "Metadata")
                        .appending("generate_if_modified.txt")
                ],
                outputFiles: [
                    outputPath
                ]
            )
        ]
    }
}
