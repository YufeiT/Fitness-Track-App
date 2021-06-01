//
import SwiftUI
import HealthKit

struct ContentView: View {
    
    private var healthStore: HealthStore?
    @State private var steps: [Step] = [Step]()
    @State private var workouts: [Workout] = [Workout]()
    @State private var activeenergies: [ActiveEnergy] = [ActiveEnergy]()
    @State private var heartrates: [HearRate] = [HearRate]()
    @State private var sumDuration: [Double] = []
    
    
    init() {
        healthStore = HealthStore()
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Strawberry") ?? .darkGray]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "Strawberry") ?? .darkGray]

    }
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        steps = []
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
        
    }
    
    private func updateWorkoutUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        workouts = []
        sumDuration = []
        
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let duration = statistics.sumQuantity()?.doubleValue(for: .minute())
            sumDuration.append(duration ?? 0.0)
            
            let workout = Workout(duration: Int(duration ?? 0), date: statistics.startDate)
            workouts.append(workout)
        }
    }
    
    private func updateEnergyUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        activeenergies = []
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            
            let calorie = statistics.sumQuantity()?.doubleValue(for: .kilocalorie())
            
            let activeenergy = ActiveEnergy(calorie: Int(calorie ?? 0), date: statistics.startDate)
            activeenergies.append(activeenergy)
        }
        
    }
    
//    private func updateLatestHeartRate(_ statisticsSample: HKSampleQuery) {
//        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
//        let endDate = Date()
//        
//        statisticsSample.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
//
//            let calorie = statistics.sumQuantity()?.doubleValue(for: .kilocalorie())
//
//            let activeenergy = ActiveEnergy(calorie: Int(calorie ?? 0), date: statistics.startDate)
//            activeenergies.append(activeenergy)
//        }
//
//
//    }
    
    
    
    @State private var totalWorkout: Double = 0.0
    @State private var goal: Int = 180
    @EnvironmentObject var goals: Goals
    
    
    private func calculateTotalWorkout() -> Double {
        totalWorkout = sumDuration.reduce(0, +)
        goals.currentWorkout = String(totalWorkout)
        print(totalWorkout)
        return totalWorkout
    }
    

    var body: some View {
        NavigationView{
            Section {
                Motivation()
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
                            totalWorkout = calculateTotalWorkout()
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
        Section {
            Text("Current Weekly Goal: \(goals.goal) minutes")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

