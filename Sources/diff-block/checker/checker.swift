import Foundation

func runCheck() {
  let fm = FileManager.default
  let configDir = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
    .appendingPathComponent("blockertool")
  let filePath = configDir.appendingPathComponent("blocker.json")

  guard let data = try? Data(contentsOf: filePath),
    let schedule = try? JSONDecoder().decode(Schedule.self, from: data)
  else {
    print("No schedule found")
    return
  }

  let formatter = DateFormatter()
  formatter.dateFormat = "HH:mm"
  let now = formatter.string(from: Date())

  for app in schedule.apps {
    var inBlockWindow = false
    for range in app.times {
      if now >= range.startTime && now <= range.endTime {
        inBlockWindow = true
        print("\(app.appName) is currently blocked (\(range.startTime) - \(range.endTime))")
        break
      }
    }

    if inBlockWindow {
      continue  // do nothing, stays blocked
    }

    let path = "/Applications/\(app.appName)"
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/bin/chmod")
    process.arguments = ["+x", path]

    do {
      try process.run()
      process.waitUntilExit()
    } catch {
      print("Error unblocking \(app.appName)")
    }
  }
}
