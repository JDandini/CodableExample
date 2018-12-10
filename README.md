# Codable Example
## Requirements
- Xcode 10.0 or later

## Sumary 

One of the features that I was looking forward to this year WWDC was Codable, which is just a type alias of the Encodable and Decodable protocols.

I’ve just spent a whole week shifting my Swift projects from using custom JSON parsers to Decodable(while removing a lot of code! 🎉), this repository showcases what I’ve learned along the way.

In short: you can now convert a set of data from a JSON Object or Property List to an equivalent Struct/Class, basically without writing a single line of code. I demostrated it consumming a free API for [weather cast](https://www.apixu.com/) and parsing all the objects using the **Codable** protocol
