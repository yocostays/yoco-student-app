class MealMenu {
  final String mealType;
  final List<String> items;

  MealMenu({
    required this.mealType,
    required this.items,
  });
}

List<MealMenu> mealmenu = [
  MealMenu(
    mealType: "Breakfast",
    items: ["Poha", "Upma", "Idli", "Dosa", "more"],
  ),
  MealMenu(
    mealType: "Lunch",
    items: ["Veg Kolahapuri", "Rice", "Roti", "more"],
  ),
  MealMenu(
    mealType: "High-Tea",
    items: ["Paneer Pakoda", "many more"],
  ),
  MealMenu(
    mealType: "Dinner",
    items: ["Dal Rice", "Papad", "Rasgula", "Paneer Pasanda", "more"],
  ),
];
