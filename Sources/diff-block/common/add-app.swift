func addApp() {
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
  blockAppInit(named: app_list[app_name])
  var appSchedules: [TimeRange] = []
  for slot in time_slots {
    appSchedules.append(TimeRange(startTime: slot.0, endTime: slot.1))
  }
  var schedule = Schedule(apps: [])
  schedule.apps.append(AppSchedule(appName: app_list[app_name], times: appSchedules))
  addToConfig(entry: schedule)
}
