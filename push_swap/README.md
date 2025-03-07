# push_swap Tester

## What is it?

This is my custom script for testing the functionality of the 42 project "push_swap". Push_swap is designed to take a series of integers as arguments and sort them into numerical order, ideally in as few operations as possible. The operations are as follows:

- pa - Push the top element of stack B to the top of stack A.
- pb - Push the top element of stack A to the top of stack B.
- ra - Rotate stack A one place (the last element wraps around to become the first element).
- rb - Rotate stack B one place (the last element wraps around to become the first element).
- rr - Rotate both stacks at the same time.
- sa - Swap the first and second element of stack A.
- sb - Swap the first and second element of stack B.
- rra - Reverse rotate stack A one place (the first element wraps around to become the last element).
- rrb - Reverse rotate stack B one place (the first element wraps around to become the last element).
- rrr - Reverse rotate both stacks at the same time.

## What is tested?

The tester will check the basic functionality of the program, checking that all appropriate messages are printed to the correct place (ie. stdout vs stderr). It will check the number of operations the program uses to sort the arguments and will check against the provided tester that it can provide valid results. Memory leaks are also checked for during the tests. If the bonus checker exists it will also run similar tests on that.

## How does it work?

Simply place the shell script file into the push_swap root and run it. The script will compile the project if it doesn't exist along with the bonus. To run all tests, the checker provided by 42 must also be in root. 

> [!NOTE]
> Remember to give permissions to both the checker and this test script before executing

> [!NOTE]
> This tester is not a definitive guide on the functionality of push_swap. This is only my own personal tests. There may be edge cases that are not considered here. 