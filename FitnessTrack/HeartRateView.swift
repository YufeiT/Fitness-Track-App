////
////  HeartRateView.swift
////  FitnessTrack
////
////  Created by Yufei on 5/31/21.
////
//
//import SwiftUI
//
//
//struct HeartRateView: View {
//    static let dateFormatter: DateFormatter = {
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd/MM"
//        return formatter
//
//    }()
//
//    let heartrate: [HearRate]
//
//    var body: some View {
//        VStack {
//            HStack(alignment: .lastTextBaseline) {
//
//                ForEach(heartrate, id: \.id) { work in
//
//                    let yValue = Swift.min(work.latest_heartrate, 60)
//
//                    VStack {
//                        Text("\(work.latest_heartrate)")
//                            .font(.caption)
//                            .foregroundColor(Color.white)
//                        Rectangle()
//                            .fill(work.latest_heartrate > 10000 ? Color.green :Color.green)
//                            .frame(width: 20, height: CGFloat(yValue * 4))
//                        Text("\(work.date,formatter: Self.dateFormatter)")
//                            .font(.caption)
//                            .foregroundColor(Color.white)
//                    }
//                }
//
//
//
//        }.frame(maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
//        .background(Color(#colorLiteral(red: 0.4982908964, green: 0.6152341962, blue: 0.6132923961, alpha: 1)))
//        .cornerRadius(10)
//        .padding(10)
//    }
//    }
//}
//
//struct HeartRateView_Previews: PreviewProvider {
//    static var previews: some View {
//        let heartrate = [
//            HearRate(latest_heartrate: 40, date: Date()),
//            HearRate(latest_heartrate: 123, date: Date()),
//            HearRate(latest_heartrate: 50, date: Date()),
//            HearRate(latest_heartrate: 100, date: Date()),
//            HearRate(latest_heartrate: 130, date: Date())
//        ]
//
//        //StepGraphView(steps: steps)
//        HeartRateView(heartrate: heartrate)
//    }
//}
