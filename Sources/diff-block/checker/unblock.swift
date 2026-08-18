import Foundation

func unblockApp(path: String) {
  let process = Process()
  process.executableURL = URL(fileURLWithPath: "/bin/chmod")
  process.arguments = ["+x", path]
  do {
    try process.run()
    process.waitUntilExit()
  } catch {
    print("Error unblocking app at \(path)")
  }
}
