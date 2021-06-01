//
//  ChangeGoalView.swift
//  FitnessTrack
//
//  Created by Yufei on 5/31/21.
//

import SwiftUI

struct ChangeGoalView: View {
    @State var duration: String = ""
    @State var isPrivate: Bool = true
    @State var notificationsEnabled: Bool = false
    @State private var previewIndex = 0
    @State private var showActionSheet = false
    var previewOptions = ["Always", "When Unlocked"]
    @State private var showAlert = false
    @EnvironmentObject var goals: Goals
    
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public func get_goal(){
        goals.goal = duration
    }

    var body: some View {
        Form {
            Section(header: Text("Weekly Exercise Goal")) {
                TextField("Duration in minutes", text: $duration)
                Toggle(isOn: $isPrivate) {
                    Text("Private Account")
                }
            }
            
            
            Section(header: Text("NOTIFICATIONS")) {
                Toggle(isOn: $notificationsEnabled) {
                    Text("Enabled")
                }
                Picker(selection: $previewIndex, label: Text("Show Previews")) {
                    ForEach(0 ..< previewOptions.count) {
                        Text(self.previewOptions[$0])
                    }
                }
            }
            Section {
                Button("Save New Goal") {
                        showActionSheet = true
                    }
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(title: Text("Save"),
                                    buttons: [
                                        .destructive(
                                            Text("Ok"),
                                            action: {self.presentationMode.wrappedValue.dismiss()
                                                self.get_goal()
                                            }
                                        ),
                                        .default(
                                            Text("Cancel"),
                                            action: {self.presentationMode.wrappedValue.dismiss()}
                                        )
                                    ]
                        )
                    }
            }
        }
    }
}

struct ChangeGoalView_Previews: PreviewProvider {
static var previews: some View {
    ChangeGoalView()
}
}

