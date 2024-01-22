import SwiftUI

struct MealDetailView: View {
    let idMeal: String
    @StateObject var viewModel = MealDetailViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let imageUrlString = viewModel.mealDetail?.strMealThumb,
                   let imageUrl = URL(string: imageUrlString) {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                
                Text(viewModel.mealDetail?.strMeal ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10)
                
                if let ingredients = viewModel.mealDetail?.ingredients, !ingredients.isEmpty {
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.bottom, 5)

                    ForEach(ingredients.indices, id: \.self) { index in
                        let ingredient = ingredients[index]
                        Text("\(index + 1). \(ingredient.name): \(ingredient.measure)")
                            .padding(.bottom, 2)
                    }
                } else {
                    Text("No ingredients available")
                }

                if let instructions = viewModel.mealDetail?.strInstructions {
                                    Text("Instructions")
                                        .font(.headline)
                                        .padding(.vertical, 5)

                                    let instructionSteps = instructions.components(separatedBy: "\r\n")
                                    ForEach(0..<instructionSteps.count, id: \.self) { index in
                                        let step = instructionSteps[index]
                                        if !step.isEmpty {
                                            Text("\(index + 1). \(step)")
                                                .padding(.bottom, 2)
                                        }
                                    }
                                } else {
                                    Text("No instructions available")
                                }
            }
            .padding()
        }
        .navigationTitle("Meal Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchMealDetail(forMealId: idMeal)
        }
    }
}
