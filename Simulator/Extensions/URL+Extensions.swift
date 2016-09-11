import Foundation

extension NSURL {

  var removeTrailingSlash: NSURL {
    guard absoluteString.hasSuffix("/") else { return self }

    let string = absoluteString.substringToIndex(absoluteString.endIndex.predecessor())
    return NSURL(string: string)!
  }
}
