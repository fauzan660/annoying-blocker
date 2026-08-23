import Foundation

func loadSchedule() -> Schedule {
  let userHome = "/Users/fauzantahir"
  let configDir = URL(fileURLWithPath: userHome)
    .appendingPathComponent("Library/Application Support/blockertool")
  let filePath = configDir.appendingPathComponent("blocker.json")

  guard let data = try? Data(contentsOf: filePath),
    let schedule = try? JSONDecoder().decode(Schedule.self, from: data)
  else {
    return Schedule(apps: [])
  }
  return schedule
}

func stripAppExtension(_ name: String) -> String {
  if name.hasSuffix(".app") {
    return String(name.dropLast(4))
  }
  return name
}

func displayAppNames(schedule: Schedule) -> [String] {
  var names = schedule.apps.map { stripAppExtension($0.appName) }
  names.append("Add app")
  return names
}
