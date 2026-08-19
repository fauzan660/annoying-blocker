import Foundation

// File1.swift
func directoryScan(path: String) -> [String] {
  let fm = FileManager.default

  do {
    print("Found items")
    let items = try fm.contentsOfDirectory(atPath: path)

    return items
  } catch {
    print("Error scanning dir")
    // failed to read directory – bad permissions, perhaps?
  }
  return []
}
