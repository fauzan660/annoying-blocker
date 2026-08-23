import Foundation

func appActionMenu() -> [String] {
  return ["Edit time ranges", "Remove app"]
}
func removeApp(named appName: String, from schedule: Schedule) {
  var updatedSchedule = schedule
  updatedSchedule.apps.removeAll { $0.appName == appName }
  addToConfig(entry: updatedSchedule)
}
