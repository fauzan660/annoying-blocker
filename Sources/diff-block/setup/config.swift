import Foundation

struct TimeRange: Codable {
  let startTime: String
  let endTime: String
}

struct AppSchedule: Codable {
  let appName: String
  let times: [TimeRange]
}

struct Schedule: Codable {
  var apps: [AppSchedule]
}
func addToConfig(entry: Schedule) {
  func getConfigDirectory() -> URL {
    let paths = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
    return paths[0].appendingPathComponent("blockertool")
  }

  let pathDirectory = getConfigDirectory()
  try? FileManager().createDirectory(at: pathDirectory, withIntermediateDirectories: true)
  let filePath = pathDirectory.appendingPathComponent("blocker.json")
  let json = try? JSONEncoder().encode(entry)
  do {
    try json!.write(to: filePath)
  } catch {
    print("Failed to write JSON data: \(error.localizedDescription)")
  }
}
