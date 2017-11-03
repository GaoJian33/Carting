//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation

struct Arguments {

    enum Command {
        case script(name: String), link(name: String), unlink(name: String), help
    }

    private enum Keys {
        static let defaultScriptName = "Carthage"
    }

    var command: Command = .help

    init?(arguments: [String]) {
        for (index, argument) in arguments.enumerated() {
            switch argument.lowercased() {
            case "-s", "--script":
                let nameIndex = index + 1
                let name = arguments.count > nameIndex ? arguments[nameIndex] : Keys.defaultScriptName
                command = .script(name: name)
            case "-l", "--link":
                let frameworkNameIndex = index + 1
                guard arguments.count > frameworkNameIndex else {
                    return nil
                }
                command = .link(name: arguments[frameworkNameIndex])
            case "-u", "--unlink":
                let frameworkNameIndex = index + 1
                guard arguments.count > frameworkNameIndex else {
                    return nil
                }
                command = .unlink(name: arguments[frameworkNameIndex])
            case "help":
                command = .help
            default: break
            }
        }
    }

    static let description: String = {
        return """
Usage: carting [options]
  -s, --script:
      Update the script with specified name.
  -l, --link:
      Link the framework with specified name to every target.
  -u, --unlink:
      Unlink the framework with specified name to every target.
"""
    }()
}
