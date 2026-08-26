import Foundation

func searchConfig() {
  let schedule = loadSchedule()
  let displayNames = displayAppNames(schedule: schedule)
  let choice = confirmationPicker(question: "Select app to edit:", options: displayNames)
  if choice == displayNames.count - 1 {
    addApp()
  } else {
    let selectedApp = schedule.apps[choice]
    let action = confirmationPicker(question: "\(selectedApp.appName):", options: appActionMenu())

    if action == 0 {
      let timeOptions = timeRangeMenu(app: selectedApp)
      let rangeChoice = confirmationPicker(question: "Time ranges:", options: timeOptions)
      if rangeChoice == selectedApp.times.count {
        addTimeRange(to: selectedApp.appName, schedule: schedule)
      } else {
        let selectedRange = selectedApp.times[rangeChoice]
        let rangeAction = confirmationPicker(
          question: "\(selectedRange.startTime) - \(selectedRange.endTime):",
          options: ["Edit", "Remove"]
        )
        if rangeAction == 0 {
          // edit — leave empty for now
        } else {
          removeTimeRange(appName: selectedApp.appName, rangeIndex: rangeChoice, from: schedule)
        }
      }
    } else {
      removeApp(named: selectedApp.appName, from: schedule)
    }
  }
}
