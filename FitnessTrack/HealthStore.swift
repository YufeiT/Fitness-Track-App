import Foundation
import HealthKit

extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

class HealthStore {
    
    var healthStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    var queryWorkout: HKStatisticsCollectionQuery?
    var queryEneygy: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void) {
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        
        let anchorDate = Date.mondayAt12AM()
        
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
        
    }
    
    func calculateWorkoutTime(completion: @escaping (HKStatisticsCollection?) -> Void) {

        let workoutTime = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!

        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())

        let anchorDate = Date.mondayAt12AM()

        let daily = DateComponents(day: 1)

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)

        queryWorkout = HKStatisticsCollectionQuery(quantityType: workoutTime, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)

        queryWorkout!.initialResultsHandler = { queryWorkout, statisticsCollection, error in
            completion(statisticsCollection)
        }

        if let healthStore = healthStore, let queryWorkout = self.queryWorkout {
            healthStore.execute(queryWorkout)
        }
    }
    
    func calculateActiveEnerygy(completion: @escaping (HKStatisticsCollection?) -> Void) {

        let activeEneygy = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!

        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())

        let anchorDate = Date.mondayAt12AM()

        let daily = DateComponents(day: 1)

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)

        queryEneygy = HKStatisticsCollectionQuery(quantityType: activeEneygy, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)

        queryEneygy!.initialResultsHandler = { queryEneygy, statisticsCollection, error in
            completion(statisticsCollection)
        }

        if let healthStore = healthStore, let queryEneygy = self.queryEneygy {
            healthStore.execute(queryEneygy)
        }
    }
    
    func latestHeartRate(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let currentRate = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())

        let anchorDate = Date.mondayAt12AM()

        let daily = DateComponents(day: 1)

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)

        queryEneygy = HKStatisticsCollectionQuery(quantityType: currentRate, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        queryEneygy!.initialResultsHandler = { queryEneygy, statisticsCollection, error in
            completion(statisticsCollection)
        }

        if let healthStore = healthStore, let queryEneygy = self.queryEneygy {
            healthStore.execute(queryEneygy)
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        let workoutType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!
        let activeEnergyType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        
        guard let healthStore = self.healthStore else { return completion(false) }
        
        healthStore.requestAuthorization(toShare: [], read: [stepType, workoutType, activeEnergyType, heartRateType]) { (success, error) in
            completion(success)
        }
        
    }
    
}
