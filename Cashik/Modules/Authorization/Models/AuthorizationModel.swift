
struct AuthorithationScreen{
    let title: String
    let description: String
}

struct AuthorizationStack{
    var stack: [Int] = Array()
    
    mutating func pop() -> Int? {
        return stack.popLast()
    }
    
    mutating func add(index: Int){
        stack.append(index)
    }
}
