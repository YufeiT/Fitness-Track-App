import SwiftUI

struct ActiveEnergyGraphView: View {


    static let dateFormatter: DateFormatter = {

        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter

    }()

    let activeenergy: [ActiveEnergy]

    var totalEnergy: Int {
        activeenergy.map { $0.calorie }.reduce(0,+)
    }

    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {

                ForEach(activeenergy, id: \.id) { energy in

                    let yValue = Swift.min(energy.calorie/20, 300)

                    VStack {
                        Text("\(energy.calorie)")
                            .font(.caption)
                            .foregroundColor(Color.white)
                        Rectangle()
                            .fill(energy.calorie > 10000 ? Color.green :Color.red)
                            .frame(width: 20, height: CGFloat(yValue * 4))
                        Text("\(energy.date,formatter: Self.dateFormatter)")
                            .font(.caption)
                            .foregroundColor(Color.white)
                    }
                }

            }

            Text("Total Calorie Burned: \(totalEnergy)").padding(.top, 15)
                .foregroundColor(Color.white)
                .opacity(0.5)

        }.frame(maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.4982908964, green: 0.6152341962, blue: 0.6132923961, alpha: 1)))
        .cornerRadius(10)
        .padding(10)
    }
}


struct ActiveEnergyGraphView_Previews: PreviewProvider {
    static var previews: some View {
        let energy = [
            ActiveEnergy(calorie: 40, date: Date()),
            ActiveEnergy(calorie: 123, date: Date()),
            ActiveEnergy(calorie: 50, date: Date()),
            ActiveEnergy(calorie: 100, date: Date()),
            ActiveEnergy(calorie: 130, date: Date())
        ]
        ActiveEnergyGraphView(activeenergy: energy)
    }
}
