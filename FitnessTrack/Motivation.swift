//
//  Motivation.swift
//  FitnessTrack
//
//  Created by Yufei on 6/1/21.
//

import SwiftUI

struct Motivation: View {
    
    @EnvironmentObject var goals: Goals
    private func motiDecision() -> Int {
        if goals.currentWorkout.isEmpty || goals.goal.isEmpty{
            print("They are empty")
            return 0
        }
        else if Double(goals.currentWorkout) ?? 0.0 >= Double(goals.goal) ?? 0.0{
            return 1
        }
        else if Double(goals.currentWorkout) ?? 0.0 < Double(goals.goal) ?? 0.0{
            return -1
        }
        else{
            return 0
        }
        
    }
    var body: some View {
        if motiDecision() == 1{
            Text("Yay, you reached your weekly goal!")
        }
        else if motiDecision() == -1{
            Text("Keep up, you are almost there!")
        }
        else{
            Text("Click Modify Goal to set your weekly goal")
        }
    }
}


struct Motivation_Previews: PreviewProvider {
    static var previews: some View {
        Motivation()
    }
}
