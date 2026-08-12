import ANSITerminal
import Foundation

func confirmationPicker(question: String, options: [String]) -> Int {

  var activeIndex = 0

  //helper functions
  func writeAt(_ row: Int, _ col: Int, _ text: String) {
    moveTo(row, col)
    write(text)
  }

  func reRender(startLine: Int) {
    options.enumerated().forEach { index, option in
      let line = startLine + index
      let isActive = index == activeIndex
      writeAt(line, 3, isActive ? "●".lightGreen : "○".foreColor(250))
      writeAt(line, 5, isActive ? option : option.foreColor(250))
    }
  }

  //move prompt to top
  write(CSI, "2J")
  write(CSI, "1H")

  //formality
  cursorOff()
  moveLineDown()
  write("◆".foreColor(81).bold)
  moveRight()

  write(question)
  let startLine = readCursorPos().row + 1

  //drawing the options
  options.enumerated().forEach { index, option in
    moveLineDown()

    write("│".foreColor(81))
    moveRight()

    write(index == activeIndex ? "●".lightGreen : "○".foreColor(250))
    moveRight()

    write(index == activeIndex ? option : option.foreColor(250))
  }
  moveLineDown()
  let bottomLine = readCursorPos().row

  write("└".foreColor(81))

  //handling user input

  while true {
    clearBuffer()
    if keyPressed() {
      let char = readChar()
      if char == NonPrintableChar.enter.char() {
        break
      }
      let key = readKey()
      if key.code == .up && activeIndex > 0 {
        activeIndex -= 1
        reRender(startLine: startLine)
      } else if key.code == .down && activeIndex < options.count - 1 {
        activeIndex += 1
        reRender(startLine: startLine)
      }
    }
  }

  //get selected option
  writeAt(startLine - 1, 0, "✔".green)
  (startLine...bottomLine).forEach { writeAt($0, 0, "│".foreColor(252)) }
  moveTo(bottomLine, 0)
  //reset terminal
  write(CSI, "0m")

  cursorOn()

  return activeIndex
}
