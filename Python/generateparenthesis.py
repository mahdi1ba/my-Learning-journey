def generateParenthesis(n):
    stack = []
    res = []
    def backtrack(openN, closedN):
        if openN == closedN == n:
            res.append("".join(stack))
            print('res: ',res)
            return
        if openN < n:
            stack.append("(")
            print('openN: ',openN)
            print('closeN: ',closedN)
            print('stack ( opened :', stack)
            backtrack(openN + 1,closedN)
            stack.pop()
            print('stack after pop ( opened :', stack)

        if closedN < openN:
            stack.append(")")
            print('openN: ',openN)
            print('closeN: ',closedN)
            print('stack ) opened:', stack)
            backtrack(openN,closedN + 1)
            stack.pop()
            print('stack after pop ) opened :', stack)

    backtrack(0, 0)
    return res

print(generateParenthesis(3))