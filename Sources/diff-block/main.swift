import Foundation

let grant = ["Yes", "No"]
// Entry point
let granted = confirmationPicker(
  question: "Would you like to give Full Disk Access to your terminal?", options: grant)

if granted != 1 {
  let process = Process()
  process.executableURL = URL(fileURLWithPath: "/bin/bash")
  process.arguments = [
    "-c", "open 'x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles'",
  ]
  try process.run()
  process.waitUntilExit()

  let result = directoryScan(path: "/Applications")
  print(result)

} else {
  print("Access denied. Some features may not work.")
}
