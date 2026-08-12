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

  let app_list = directoryScan(path: "/Applications")
  let app = confirmationPicker(
    question: "Choose the app you would like to block", options: app_list)

  let slots = 3
  var results: [(String, String)] = []

  for i in 1...slots {
    let start = timePicker(question: "Slot \(i) start time:")
    let end = timePicker(question: "Slot \(i) end time:")
    results.append((start, end))
  }
  timePickerDisp(results: results)

} else {
  print("Access denied. Some features may not work.")
}
