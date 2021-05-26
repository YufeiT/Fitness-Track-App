import Foundation

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
