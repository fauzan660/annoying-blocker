import Foundation

func blockApp(named appName: String) {
  let path = "/Applications/\(appName)"
  let process = Process()
  process.executableURL = URL(fileURLWithPath: "/bin/chmod")
  process.arguments = ["-R", "-x", path]
  try? process.run()
  process.waitUntilExit()
}
