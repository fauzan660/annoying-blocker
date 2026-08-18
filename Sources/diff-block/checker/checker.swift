import Foundation

func isAppBlocked(path: String) -> Bool {
  let fm = FileManager.default
  do {
    let attrs = try fm.attributesOfItem(atPath: path)
    guard let permissions = attrs[.posixPermissions] as? Int else {
      print("[ERROR] could not read posixPermissions for \(path)")
      return false
    }
    return permissions & 0o111 == 0
  } catch {
    print("[ERROR] attributesOfItem failed for \(path): \(error)")
    return false
  }
}

func runCheck() {
  let configDir = URL(fileURLWithPath: "/Users/fauzantahir")
    .appendingPathComponent("Library/Application Support/blockertool")
  let filePath = configDir.appendingPathComponent("blocker.json")

  let data: Data
  do {
    data = try Data(contentsOf: filePath)
  } catch {
    print("[ERROR] could not read blocker.json at \(filePath.path): \(error)")
    return
  }

  let schedule: Schedule
  do {
    schedule = try JSONDecoder().decode(Schedule.self, from: data)
  } catch {
    print("[ERROR] failed to decode blocker.json: \(error)")
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
        "[ACTION] \(app.appName) entering block window (\(blockRange!.startTime) - \(blockRange!.endTime))"
      )
      blockApp(path: path)
    } else if !inBlockWindow && currentlyBlocked {
      print("[ACTION] \(app.appName) block window ended, unblocking")
      unblockApp(path: path)
    } else if inBlockWindow && currentlyBlocked {
      print(
        "[INFO] \(app.appName) already blocked (\(blockRange!.startTime) - \(blockRange!.endTime))")
    } else {
      print("[INFO] \(app.appName) not blocked, outside window")
    }
  }
}
