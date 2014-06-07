// Playground - noun: a place where people can play

var stack = [0]
var cursor = 0
let helloWorldCode = "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>."

enum Operators : Character{
    case Increase = "+"
    case Decrease = "-"
    case StartLoop = "["
    case EndLoop = "]"
    case Read = ","
    case Print = "."
    case MoveRight = ">"
    case MoveLeft = "<"
}

var operatorSequence = Operators[]()

for c in helloWorldCode {
    let op = Operators.fromRaw(c)
    operatorSequence.append(op!)
}

func alloc(){
    if cursor >= stack.count {
        for _ in 0...cursor - stack.count{
            stack.append(0)
        }
    }
}

func findEndLoop(startPoint:Int)->Int{
    for var i = startPoint + 1; i < operatorSequence.count; i += 1{
        let op = operatorSequence[i]
        switch op {
        case .EndLoop:
            i
            return i
        case .StartLoop:
            i = findEndLoop(i)
        default:
            break
        }
    }
    return 10000
}

func findStartLoop(endPoint:Int)->Int{
    for var j = endPoint - 1; j > -1; j -= 1{
        let op = operatorSequence[j]
        switch op {
        case .StartLoop:
            return j
        case .EndLoop:
            j = findStartLoop(j)
        default:
            break
        }
    }
    return 100000
}

for var i = 0; i < operatorSequence.count;i += 1 {
    let op = operatorSequence[i]
    switch op {
    case .MoveRight:
        cursor += 1
        alloc()
    case .MoveLeft:
        cursor -= 1
        alloc()
    case .Increase:
        stack[cursor] += 1
    case .Decrease:
        if --stack[cursor] < 0{
            stack[cursor] = 255
        }
    case .StartLoop:
        if stack[cursor] == 0{
            i = findEndLoop(i)
        }
    case .EndLoop:
        if stack[cursor] != 0{
            i = findStartLoop(i)
        }
    case .Print:
        print(Character(UnicodeScalar(stack[cursor])))
    case .Read:
        // Unimplemented
        break
    default:
        break
    }
}

