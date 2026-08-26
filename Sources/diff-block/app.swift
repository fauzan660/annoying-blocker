import ArgumentParser
import Foundation

@main
struct BlockerTool: ParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "App blocker tool.",
    subcommands: [Setup.self, Check.self, Config.self]
  )
}

struct Setup: ParsableCommand {
  static let configuration = CommandConfiguration(abstract: "Set up app blocking schedule.")

  mutating func run() {
    runSetup()

  }
}

struct Check: ParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "Check schedule and block/unblock apps.")

  mutating func run() {
    // build this next
    runCheck()
  }

}
struct Config: ParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "Change blocking settings")

  mutating func run() {
    // build this next
    searchConfig()
  }

}
