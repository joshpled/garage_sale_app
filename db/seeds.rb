user2 = User.new(username: "callie", email: "callie@gmail.com", password: "chancelor2A!")
user3 = User.new(username: "zullie", email: "zullie@gmail.com", password: "chancelor3A!")

user2.save
user3.save

listing2 = Listing.new(title: "Second Listing", description: "New listing")
listing3 = Listing.new(title: "Third Listing", description: "New listing")

listing2.save
listing3.save

item1 = Item.new(name: "car", price: 1.00, category: "cat1")
item2 = Item.new(name: "toy", price: 1.00, category: "cat1")
item3 = Item.new(name: "house", price: 1.00, category: "cat2")
item4 = Item.new(name: "shirt", price: 1.00, category: "cat2")
item5 = Item.new(name: "phone", price: 1.00, category: "cat3")
item6 = Item.new(name: "shoes", price: 1.00, category: "cat4")
item7 = Item.new(name: "plants", price: 1.00, category: "cat4")

item1.save
item2.save
item3.save
item4.save
item5.save
item6.save
item7.save

listing2.items<<item1
listing2.items<<item2
listing2.items<<item3

listing3.items<<item4
listing3.items<<item5
listing3.items<<item6
listing3.items<<item7

user2.listings<<listing2
user3.listings<<listing3