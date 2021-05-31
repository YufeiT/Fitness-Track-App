//
import SwiftUI
import HealthKit

struct ContentView: View {
    
    private var healthStore: HealthStore?
    @State private var steps: [Step] = [Step]()
    @State private var workouts: [Workout] = [Workout]()
    @State private var activeenergies: [ActiveEnergy] = [ActiveEnergy]()
    @State private var sumDuration = 0.0
    
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
    
    private func updateWorkoutUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) -> Double  {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let duration = statistics.sumQuantity()?.doubleValue(for: .minute())
            sumDuration = duration ?? 0.0
            
            let workout = Workout(duration: Int(duration ?? 0), date: statistics.startDate)
            workouts.append(workout)
        }
        return sumDuration
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
    
    @State private var isPresent: Bool = false
    @State private var text: String = ""
    

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
            .navigationBarItems(trailing: NavigationLink(destination: ChangeGoalView(), label: {Text("Modify Goal")}))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
