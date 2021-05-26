import SwiftUI

struct WorkoutGraphView: View {


    static let dateFormatter: DateFormatter = {

        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter

    }()

    let workout: [Workout]

    var totalWorkout: Int {
        workout.map { $0.duration }.reduce(0,+)
    }

    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {

                ForEach(workout, id: \.id) { work in

                    let yValue = Swift.min(work.duration, 60)

                    VStack {
                        Text("\(work.duration)")
                            .font(.caption)
                            .foregroundColor(Color.white)
                        Rectangle()
                            .fill(work.duration > 10000 ? Color.green :Color.green)
                            .frame(width: 20, height: CGFloat(yValue * 4))
                        Text("\(work.date,formatter: Self.dateFormatter)")
                            .font(.caption)
                            .foregroundColor(Color.white)
                    }
                }

            }

            Text("Total Workout: \(totalWorkout)").padding(.top, 15)
                .foregroundColor(Color.white)
                .opacity(0.5)

        }.frame(maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.4982908964, green: 0.6152341962, blue: 0.6132923961, alpha: 1)))
        .cornerRadius(10)
        .padding(10)
    }
}


struct WorkoutGraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        let workout = [
            Workout(duration: 40, date: Date()),
            Workout(duration: 123, date: Date()),
            Workout(duration: 50, date: Date()),
            Workout(duration: 100, date: Date()),
            Workout(duration: 130, date: Date())
        ]
        
        //StepGraphView(steps: steps)
        WorkoutGraphView(workout: workout)
    }
}
