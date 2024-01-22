import SwiftUI

struct MealsView: View {
    let category: String
    @StateObject var viewModel = MealsViewModel()

    var body: some View {
            List(viewModel.meals, id: \.idMeal) { meal in
                NavigationLink(destination: MealDetailView(idMeal: meal.idMeal)) {
                    HStack {
                        if let imageUrlString = meal.strMealThumb, let imageUrl = URL(string: imageUrlString) {
                            AsyncImage(url: imageUrl) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(5)
                        }
                        Text(meal.strMeal)
                            .padding(.leading, 8)
                    }
                }
                .padding(.vertical, 5)
            }
            .listStyle(PlainListStyle())
            .navigationTitle(category)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchMeals(forCategory: category)
            }
    }
}
