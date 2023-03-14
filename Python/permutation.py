def permute(nums):
    result = []

    #base case
    if (len(nums) == 1):
        return [nums[:]]
    for i in range(len(nums)):
        n= nums.pop(0)
        print ('n: ',n)
        print('nums: ',nums)
        
        perms = permute(nums)
        print('perms: ', perms)
        for perm in perms:
            perm.append(n)
        print ('perms: after for loop: ', perms)
        result.extend(perms)
        print("result: ",result)
        nums.append(n)
        print('nums: ',nums)
    return result

print(permute([1,2,3]))
