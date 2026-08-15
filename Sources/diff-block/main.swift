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
  let app_name = confirmationPicker(
    question: "Choose the app you would like to block", options: app_list)

  let slots = 1
  var time_slots: [(String, String)] = []

  for i in 1...slots {
    let start = timePicker(question: "Slot \(i) start time:")
    let end = timePicker(question: "Slot \(i) end time:")
    time_slots.append((start, end))
  }
  timePickerDisp(results: time_slots)

  blockApp(named: app_list[app_name])

  var appSchedules: [TimeRange] = []
  for slot in time_slots {
    appSchedules.append(TimeRange(startTime: slot.0, endTime: slot.1))
  }
  var schedule = Schedule(apps: [])
  schedule.apps.append(AppSchedule(appName: app_list[app_name], times: appSchedules))

  addToConfig(entry: schedule)

} else {
  print("Access denied. Some features may not work.")
}
