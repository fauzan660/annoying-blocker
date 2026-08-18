import Foundation

func unblockApp(path: String) {
  let process = Process()
  process.executableURL = URL(fileURLWithPath: "/bin/chmod")
  process.arguments = ["+x", path]
  do {
    try process.run()
    process.waitUntilExit()
    let status = process.terminationStatus
    if status != 0 {
      print("[ERROR] chmod +x failed for \(path) — exit code \(status)")
    } else {
      print("[OK] unblocked \(path)")
    }
  } catch {
    print("[ERROR] failed to launch chmod for \(path): \(error)")
  }
}
