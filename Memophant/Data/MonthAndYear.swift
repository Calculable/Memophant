import Foundation

struct MonthAndYear: Hashable {
    
    let month: Int;
    let year: Int;
    
    init(month: Int, year: Int) {
        self.month = month
        self.year = year
    }
    
}
