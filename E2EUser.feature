Feature: Create , Update , Delete and GET the user details

Background:

  * def random_string = 
  """
    function(s){
        var text = "";
        var pattern = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        for(var i = 0; i<s ; i++)
        text += pattern.charAt(Math.floor(Math.random() * pattern.length()));
        return text;  
      }
"""
  * def randomString = random_string(10)
  * print (randomString)
  * def requestPayload = read('./user.json')

  * requestPayload.email = randomString + "@gmail.com"
  * print requestPayload  

Scenario: Create , Update , Delete and GET a user with the given data

# Create a user
  Given url baseUrl+path
  And request requestPayload
  And header Authorization = 'Bearer ' + tokenID
  When method POST
  Then status 201
  And match $.data.id == '#present'
  And match $.data.name == '#present'
  And match $.data.email == requestPayload.email
  And match $.data.gender == '#present'
  And match $.data.status == '#present'

# fetch the user
  * def userId = $.data.id
  * print userId

# GET the user  
  Given url baseUrl+ path + userId
  And header Content-Type = 'application/json; charset=utf-8'
  And header Connection = 'keep-alive'
  And header Authorization = 'Bearer ' + tokenID
  When method GET
  Then status 200
  And match $.data.id == '#present'
  And match $.data.name == '#present'
  And match $.data.email == requestPayload.email
  And match $.data.gender == 'male'
  And match $.data.status == 'active' 

# Update the user  
  * def requestPUTPayload = 
  """
  {
    "gender": "female",
    "status": "inactive"
  }
  """
  Given url baseUrl+path+userId
  And request requestPUTPayload
  And header Authorization = 'Bearer ' + tokenID
  When method PUT
  Then status 200
  And match $.data.id == '#present'
  And match $.data.name == '#present'
  And match $.data.email == requestPayload.email
  And match $.data.gender == 'female'
  And match $.data.status == 'inactive'

# GET the user   
  Given url baseUrl+path+userId
  And header Authorization = 'Bearer ' + tokenID
  When method GET
  Then status 200
  And match $.data.id == '#present'
  And match $.data.name == '#present'
  And match $.data.email == requestPayload.email
  And match $.data.gender == 'female'
  And match $.data.status == 'inactive'

#delete the user   
  Given url baseUrl+ path + userId
  And header Authorization = 'Bearer ' + tokenID
  When method DELETE
  Then status 204

# Get the user  
  Given url baseUrl+ path + userId
  And header Content-Type = 'application/json; charset=utf-8'
  And header Connection = 'keep-alive'
  And header Authorization = 'Bearer ' + tokenID
  When method GET
  Then status 404
  And match $.data.message == 'Resource not found'