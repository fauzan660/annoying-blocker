func removeTimeRange(appName: String, rangeIndex: Int, from schedule: Schedule) {
  var updatedSchedule = schedule
  if let appIndex = updatedSchedule.apps.firstIndex(where: { $0.appName == appName }) {
    updatedSchedule.apps[appIndex].times.remove(at: rangeIndex)
    addToConfig(entry: updatedSchedule)
  }
}
func addTimeRange(to appName: String, schedule: Schedule) {
  let start = timePicker(question: "New slot start time:")
  let end = timePicker(question: "New slot end time:")
  let newRange = TimeRange(startTime: start, endTime: end)

  var updatedSchedule = schedule
  if let appIndex = updatedSchedule.apps.firstIndex(where: { $0.appName == appName }) {
    updatedSchedule.apps[appIndex].times.append(newRange)
    addToConfig(entry: updatedSchedule)
  }
}
