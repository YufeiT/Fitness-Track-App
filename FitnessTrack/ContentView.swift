//
import SwiftUI
import HealthKit

struct ContentView: View {
    
    private var healthStore: HealthStore?
    @State private var steps: [Step] = [Step]()
    @State private var workouts: [Workout] = [Workout]()
    @State private var activeenergies: [ActiveEnergy] = [ActiveEnergy]()
    
    init() {
        healthStore = HealthStore()
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Strawberry") ?? .darkGray]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "Strawberry") ?? .darkGray]

    }
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
        
    }
    
    private func updateWorkoutUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let duration = statistics.sumQuantity()?.doubleValue(for: .minute())
            
            let workout = Workout(duration: Int(duration ?? 0), date: statistics.startDate)
            workouts.append(workout)
        }
        
    }
    
    private func updateEnergyUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let calorie = statistics.sumQuantity()?.doubleValue(for: .kilocalorie())
            
            let activeenergy = ActiveEnergy(calorie: Int(calorie ?? 0), date: statistics.startDate)
            activeenergies.append(activeenergy)
        }
        
    }

    
//    var body: some View {
//
//        NavigationView {
//
//        StepGraphView(steps: steps)
//        .navigationTitle("Fitness Summary")
//        }
//        .onAppear {
//            if let healthStore = healthStore {
//                healthStore.requestAuthorization { success in
//                    if success {
//                        healthStore.calculateSteps { statisticsCollection in
//                            if let statisticsCollection = statisticsCollection {
//                                // update the UI
//                                updateUIFromStatistics(statisticsCollection)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//
//        //WorkoutGraphView(workout: workouts)
//    }
    var body: some View {
        NavigationView{
            Section {
                ScrollView{
                    StepGraphView(steps: steps)
                        .onAppear {
                            if let healthStore = healthStore {
                                healthStore.requestAuthorization { success in
                                    if success {
                                        healthStore.calculateSteps { statisticsCollection in
                                            if let statisticsCollection = statisticsCollection {
                                                // update the UI
                                                updateUIFromStatistics(statisticsCollection)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                    
                    WorkoutGraphView(workout: workouts)
                        .onAppear {
                            if let healthStore = healthStore {
                                healthStore.requestAuthorization { success in
                                    if success {
                                        healthStore.calculateWorkoutTime { statisticsCollection in
                                            if let statisticsCollection = statisticsCollection {
                                                // update the UI
                                                updateWorkoutUIFromStatistics(statisticsCollection)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    
                    
                    ActiveEnergyGraphView(activeenergy: activeenergies)
                        .onAppear {
                            if let healthStore = healthStore {
                                healthStore.requestAuthorization { success in
                                    if success {
                                        healthStore.calculateActiveEnerygy { statisticsCollection in
                                            if let statisticsCollection = statisticsCollection {
                                                // update the UI
                                                updateEnergyUIFromStatistics(statisticsCollection)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                }
            }
            .navigationTitle("Health Data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
