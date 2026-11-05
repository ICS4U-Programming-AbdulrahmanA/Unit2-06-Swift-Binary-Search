// The list contains 10 numbers, each from 0 to 100.
let arraySize = 10
let maxRandomNumber = 100

// Search a sorted list by repeatedly checking the middle number.
func binarySearch(_ numbers: [Int], target: Int) -> Int {
    // Start with the entire list as the range where the target could be.
    var low = 0
    var high = numbers.count - 1

    // Continue while there are still positions left to check.
    while low <= high {
        // Find the midpoint without adding low and high directly.
        let middle = low + (high - low) / 2

        if numbers[middle] == target {
            // Return the position when the target matches the midpoint.
            return middle
        } else if numbers[middle] < target {
            // The target can only be in the right half.
            low = middle + 1
        } else {
            // The target can only be in the left half.
            high = middle - 1
        }
    }

    // An empty search range means the target is not in the list.
    return -1
}

// Make a new list of random numbers.
func populateArray() -> [Int] {
    (0..<arraySize).map { _ in Int.random(in: 0...maxRandomNumber) }
}

// Run the number-searching game until the user quits.
func playGame() {
    // Tell the user what to do before showing the first list.
    print("Choose a number from the list to search for. Type 'q' to quit.")

    // Keep playing until the user enters q.
    var input = ""
    while input.lowercased() != "q" {
        // Create and sort a fresh list; binary search requires sorted values.
        var numbers = populateArray()
        numbers.sort()

        // Show the whole list before waiting for the user's number.
        print(numbers.map(String.init).joined(separator: " "))
        print("Number:")

        // Read one line of input. Stop if the program receives no more input.
        guard let nextInput = readLine() else {
            break
        }
        input = nextInput

        // Let the user quit with either q or Q.
        if input.lowercased() == "q" {
            print("Thanks for playing!")
            continue
        }

        // Convert the user's text to a whole number.
        guard let target = Int(input) else {
            print("Invalid input. Enter a whole number or 'q' to quit.")
            continue
        }

        // Search the list and report whether the number was found.
        let index = binarySearch(numbers, target: target)
        if index >= 0 {
            print("\(target) is in the list at index \(index).")
        } else {
            print("\(target) is not in the list.")
        }
    }
}

// The main function starts the game by calling its game-loop function.
func main() {
    playGame()
}

main()
