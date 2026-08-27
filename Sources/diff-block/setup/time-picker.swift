import ANSITerminal
import Foundation

func timePickerDisp(results: [(String, String)]) {
  write(CSI, "2J")
  write(CSI, "1H")
  print("Your blocked time slots:")
  for (i, slot) in results.enumerated() {
    print("Slot \(i + 1): \(slot.0) - \(slot.1)")
  }

}

func timePicker(question: String) -> String {
  var hour = 9
  var minute = 0
  var field = 0

  func readKeyPress() -> String {
    var buf = [UInt8](repeating: 0, count: 3)
    let n = read(STDIN_FILENO, &buf, 3)
    guard n > 0 else { return "" }
    if buf[0] == 27 && buf[1] == 91 {
      if buf[2] == 65 { return "up" }
      if buf[2] == 66 { return "down" }
      if buf[2] == 67 { return "right" }
      if buf[2] == 68 { return "left" }
    }
    if buf[0] == 13 { return "enter" }
    return ""
  }
  func writeAt(_ row: Int, _ col: Int, _ text: String) {
    moveTo(row, col)
    write(text)
  }

  func render(startLine: Int) {
    let hourStr = String(format: "%02d", hour)
    let minuteStr = String(format: "%02d", minute)
    writeAt(startLine, 2, "┌──────────┐".foreColor(240))
    writeAt(startLine + 1, 2, "│".foreColor(240))
    write(
      " \(field == 0 ? hourStr.lightGreen : hourStr) : \(field == 1 ? minuteStr.lightGreen : minuteStr) "
    )
    write("↕".foreColor(240))
    write("│".foreColor(240))
    writeAt(startLine + 2, 2, "└──────────┘".foreColor(240))
  }

  write(CSI, "2J")
  write(CSI, "1H")
  cursorOff()
  moveLineDown()
  write("◆".foreColor(81).bold)
  moveRight()
  write(question)
  let startLine = readCursorPos().row + 1

  render(startLine: startLine)

  while true {
    let key = readKeyPress()
    if key == "enter" { break }
    if key == "left" { field = 0 }
    if key == "right" { field = 1 }
    if key == "up" {
      if field == 0 { hour = (hour + 1) % 24 } else { minute = (minute + 1) % 60 }
    }
    if key == "down" {
      if field == 0 { hour = (hour - 1 + 24) % 24 } else { minute = (minute - 1 + 60) % 60 }
    }
    render(startLine: startLine)
  }
  write(CSI, "0m")

  cursorOn()

  return String(format: "%02d:%02d", hour, minute)
}
