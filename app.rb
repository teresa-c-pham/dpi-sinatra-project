require "sinatra"
require "sinatra/reloader"
require "http"


get("/") do
  erb(:main)
end

get("/generate") do
  @outcome = params.fetch("animal")
  random = ["Cat", "Dog", "Fox", "Duck"].sample

  # List of APIs
  cat_api = "https://api.thecatapi.com/v1/images/search"
  fox_api = "https://randomfox.ca/floof/?ref=apilist.fun"
  dog_api = "https://dog.ceo/api/breeds/image/random"
  duck_api = "https://random-d.uk/api/random"

  
  # Check if random was selected
  if @outcome == "Surprise"
    @outcome = random
  end

  # Call Different API for each animal type
  if @outcome == "Cat"
    @message = ["Cats!", "More Cats!", "Even More Cats!", "I did it", "Don't I Look Cute?", "Meow~"].sample
    cat = HTTP.get(cat_api).to_s
    cat_data = JSON.parse(cat)
    data = cat_data[0]
    @img = data["url"]

  elsif @outcome == "Fox"
    @message = ["Floofy!", "Sly~", "Sassssy", "Need Some Hugs", "Don't I Look Cute?"].sample
    fox = HTTP.get(fox_api).to_s
    fox_data = JSON.parse(fox)
    @img = fox_data["image"]
  elsif @outcome == "Dog"
    @message = ["I'm a good boy", "Happy~", "Lookin' smug", "More Doggos!", "Even More Doggo Pics!", "Doggos!", "Woof"].sample
    dog = HTTP.get(dog_api).to_s
    dog_data = JSON.parse(dog)
    @img = dog_data["message"]
  else
    @message = ["I'm a duck", "Fluffy Duck", "Funky Duck", "Quack", "Quack Quack"].sample
    duck = HTTP.get(duck_api).to_s
    duck_data = JSON.parse(duck)
    @img = duck_data["url"]
  end

  erb(:generate)
end
