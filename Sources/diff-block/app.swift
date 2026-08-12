import Foundation

// File1.swift
func directoryScan(path: String) -> Int {
  let fm = FileManager.default

  do {
    let items = try fm.contentsOfDirectory(atPath: path)

    for item in items {
      print("Found \(item)")
    }
    return 1
  } catch {
    print("Error scanning dir")
    // failed to read directory – bad permissions, perhaps?
  }
  return 0
}
