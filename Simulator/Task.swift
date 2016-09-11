import Cocoa

struct Task {

  static func output(launchPath: String, arguments: [String],
                     directoryPath: String? = nil) -> String {

    let task = NSTask()
    task.launchPath = launchPath
    task.arguments = arguments
    task.standardOutput = NSPipe()

    if let directoryPath = directoryPath {
      task.currentDirectoryPath = directoryPath
    }

    let file = task.standardOutput?.fileHandleForReading
    task.launch()

    // For some reason [task waitUntilExit]; does not return sometimes. Therefore this rather hackish solution:
    var count = 0;
    while task.running && count < 10 {
      NSThread.sleepForTimeInterval(0.1)
      count += 1
    }

    guard let data = file?.readDataToEndOfFile(),
      result = String(data: data, encoding: NSUTF8StringEncoding)
      else {
      return ""
    }

    return result
  }
}
