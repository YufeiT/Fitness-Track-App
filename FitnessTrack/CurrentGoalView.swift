//
//  CurrentGoalView.swift
//  FitnessTrack
//
//  Created by Yufei on 5/31/21.
//

import SwiftUI

struct CurrentGoalView: View {
    @EnvironmentObject var currentGoal: Goals
    var body: some View {
        Text("Current Goal: \(currentGoal.goal)")
    }
}

struct CurrentGoalView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentGoalView()
    }
}
