import Foundation

func runSetup() {

  let grant = ["Yes", "No"]
  // Entry point
  let granted = confirmationPicker(
    question: "Would you like to give Full Disk Access to your terminal?", options: grant)

  if granted != 1 {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/bin/bash")
    process.arguments = [
      "-c", "open 'x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles'",
    ]
    do {
      try process.run()
      process.waitUntilExit()

    } catch {
      print("Error while running process")
    }

    addApp()

  } else {
    print("Access denied. Some features may not work.")
  }
}
