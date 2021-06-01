import Foundation
import UIKit

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}

struct Workout: Identifiable {
    let id = UUID()
    let duration: Int
    let date: Date
}

struct ActiveEnergy: Identifiable {
    let id = UUID()
    let calorie: Int
    let date: Date
}

struct HearRate: Identifiable {
    let id = UUID()
    let latest_heartrate: Int
    let date: Date
}

class Goals: ObservableObject{
    @Published var goal = ""
    @Published var currentWorkout = ""
}
