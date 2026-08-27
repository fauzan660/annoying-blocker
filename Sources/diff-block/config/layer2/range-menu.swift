import Foundation

func timeRangeMenu(app: AppSchedule) -> [String] {
  var options = app.times.map { "\($0.startTime) - \($0.endTime)" }
  options.append("Add time range")
  return options
}
