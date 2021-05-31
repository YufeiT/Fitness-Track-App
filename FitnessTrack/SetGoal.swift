//
//  SetGoalView.swift
//  FitnessTrack
//
//  Created by Yufei on 5/31/21.
//

import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct SetGoalView: View {
    var title: String = ""
    @Binding var isShown: Bool
    @Binding var text: String
    var onDone: (String) -> Void = { _ in }
    var onCancel: () -> Void = {}
    
    
    var body: some View {
        VStack{
            Text(title)
            TextField("", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack{
                Button("Done"){
                    self.isShown = false
                    self.onDone(self.text)
                }
                Button("Cancel"){
                    self.isShown = false
                    self.onCancel()
                }
            }
        } .padding()
        .frame(width: UIScreen.screenWidth * 0.7, height: UIScreen.screenHeight * 0.3)
            .background(Color(#colorLiteral(red: 0.8402689099, green: 0.8404105306, blue: 0.8402502537, alpha: 0.5632174745)))
            .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
            .offset(y: isShown ? 0 : UIScreen.screenHeight)
        .shadow(color: Color(#colorLiteral(red: 0.8402689099, green: 0.8404105306, blue: 0.8402502537, alpha: 0.5632174745)), radius: 6, x: -9, y: -9)
    }
}

struct SetGoalView_Previews: PreviewProvider {
    static var previews: some View {
        SetGoalView(isShown: .constant(true), text: .constant(""))
    }
}
