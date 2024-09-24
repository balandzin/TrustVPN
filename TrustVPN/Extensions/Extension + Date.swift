import Foundation

extension Date {
    
    func toString(format: String = "MMMM") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func getDayNameAbbreviation() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let fullDayName = dateFormatter.string(from: self)
        let abbreviation = String(fullDayName.prefix(2))
        return abbreviation
    }
    
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    func hasLoggedInToday(lastLogin: Date) -> Bool {
        let currentDate = Calendar.current.startOfDay(for: self)
        let lastLoginDate = Calendar.current.startOfDay(for: lastLogin)
        return currentDate == lastLoginDate
    }
}
