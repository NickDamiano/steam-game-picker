class FriendsFilter
 def self.run(friends)
   #takes in the existing pool of games, and an array of friends names and whether or not they are selected. 
   selected_friends = []
   friends.each do |friend, val|
     if val == "1"
       selected_friends.push(friend)
     end
   end
   return selected_friends
 end
end