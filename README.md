# README

# For creating new random phone number:

/phones/new.json?user_name=Name

# For creating new not random phone number:

/phones/new.json?user_name=Name&phone=123-456-7891

# Example of API answer:

{
  user_name: "Name",
  number: "123-456-7891"
}

# For testing the API:

rspec spec

# Used RoR versions:

ruby v.2.5.1, rails v.5.2.1
