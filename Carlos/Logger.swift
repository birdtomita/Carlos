import Foundation

/// A simple logger to use instead of println with configurable output closure
public class Logger {
  public enum Level : String {
    case Debug = "Debug"
    case Info = "Info"
    case Warning = "Warning"
    case Error = "Error"
  }

  private static var queue = dispatch_queue_create(CarlosGlobals.QueueNamePrefix + "logger", DISPATCH_QUEUE_SERIAL)

  /**
  Called to output the log message. Override for custom logging.
  */
  public static var output: (String, Level) -> Void = { msg, level in
    dispatch_async(queue) {
      println("[Carlos][\(level.rawValue)]: \(msg)")
    }
  }

  /**
  Logs a message on the console
  
  :param: message The message to log
  
  :discussion: This method uses the output closure internally to output the message
  */
  public static func log(message: String, level: Level = Level.Debug) {
    output(message, level)
  }
}