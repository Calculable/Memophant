import Foundation


extension Date {
    
    //See https://stackoverflow.com/questions/53356392/how-to-get-day-and-month-from-date-type-swift-4
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    var formatedTime: String {
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none

        // get the date time String from the date object
        let timeString = formatter.string(from: self)
        return timeString
    }
    
    var year: Int {
        return get(.year).year!
    }
    
    var month: Int {
        return get(.month).month!
    }
    
    var day: Int {
        return get(.day).day!
    }
}
