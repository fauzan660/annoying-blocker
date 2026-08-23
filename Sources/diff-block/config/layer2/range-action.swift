func removeTimeRange(appName: String, rangeIndex: Int, from schedule: Schedule) {
  var updatedSchedule = schedule
  if let appIndex = updatedSchedule.apps.firstIndex(where: { $0.appName == appName }) {
    updatedSchedule.apps[appIndex].times.remove(at: rangeIndex)
    addToConfig(entry: updatedSchedule)
  }
}
