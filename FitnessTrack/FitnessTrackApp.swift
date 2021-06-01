//
//  FitnessTrackApp.swift
//  FitnessTrack
//
//  Created by Yufei on 5/26/21.
//

import SwiftUI

@main
struct FitnessTrackApp: App {
    @StateObject var goals = Goals()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(goals)
        }
    }
}
