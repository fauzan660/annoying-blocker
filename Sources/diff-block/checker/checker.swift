import Foundation

func isAppBlocked(path: String) -> Bool {
  let fm = FileManager.default
  guard let attrs = try? fm.attributesOfItem(atPath: path),
    let permissions = attrs[.posixPermissions] as? Int
  else {
    return false
  }
  return permissions & 0o111 == 0  // no execute bits set = blocked
}
func runCheck() {
  let userHome = "/Users/fauzantahir"
  let configDir = URL(fileURLWithPath: userHome)
    .appendingPathComponent("Library/Application Support/blockertool")
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
    let path = "/Applications/\(app.appName)"
    let currentlyBlocked = isAppBlocked(path: path)
    var inBlockWindow = false
    var blockRange: TimeRange? = nil

    for range in app.times {
      if now >= range.startTime && now <= range.endTime {
        inBlockWindow = true
        blockRange = range

        break
      }
    }

    if inBlockWindow && !currentlyBlocked {
      print(
        "\(app.appName) entering block window (\(blockRange!.startTime) - \(blockRange!.endTime)), blocking now"
      )
      blockApp(path: path)
    } else if !inBlockWindow && currentlyBlocked {
      print("\(app.appName) block window ended, unblocking now")
      unblockApp(path: path)
    } else if inBlockWindow && currentlyBlocked {
      print(
        "\(app.appName) is currently blocked (\(blockRange!.startTime) - \(blockRange!.endTime))")
    } else if !inBlockWindow && !currentlyBlocked {
      print("\(app.appName) is not blocked right now")
    }
  }
}
