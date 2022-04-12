import Foundation

struct TimeSinceDate {
    var days: Int = 0
    var hours: Int = 0
    var mins: Int = 0
    var secs: Int = 0
        
    init(timeInterval: TimeInterval) {
        var interval = timeInterval
        
        self.days = Int(interval / 86400)
        interval -= Double(days * 86400)
        
        self.hours = Int(interval / 3600)
        interval -= Double(hours * 3600)
        
        self.mins = Int(interval / 60)
        interval -= Double(mins * 60)
        
        self.secs = Int(interval)
    }
    
    public var timeString: String {
        get {
            var s = ""
            if days > 0 {
                s += ("\(days)d ago")
            } else if hours > 0 {
                s += ("\(hours)h ago")
            } else if mins > 0 {
                s += ("\(mins)m ago")
            } else {
                s += ("\(secs)s ago")
            }
            return s
        }
    }
}

