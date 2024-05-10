//
//  EditFoodView.swift
//  Calories
//
//  Created by jaewon Lee on 5/10/24.
//

import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var food: FetchedResults<Food>.Element
    
    @State private var name: String = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("\(food.name!)", text: $name)
                    .onAppear {
                        name = food.name!
                        calories = food.calories
                    }
                VStack {
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button(action: {
                        DataController().editFood(
                            food: food,
                            name: name,
                            calories: calories,
                            context: managedObjContext
                        )
                        dismiss()
                    }, label: {
                        Text("Submit")
                    })
                    Spacer()
                }
            }
        }
    }
}
