import Foundation

extension Date {
    var dateString: String { return DateFormatter.sharedFormat("dd.MM.YY HH:mm").string(from: self)
    }
    var dateTimeString: String { return DateFormatter.sharedFormat("dd.MM.YY HH:mm").string(from: self)
    }
}

private extension DateFormatter {
    static func sharedFormat(_ format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}
