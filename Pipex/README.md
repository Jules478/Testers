# Pipex Tester

## What is it?

This is my custom script for testing the functionality of the 42 project "Pipex". Pipex is designed to replicate the behaviour of redirection in shell commands. This tester is designed to test various input for this project, both valid and invalid.

## What is Tested?

The scripts will test basic valid inputs along with various error cases, for example, running with commands that don't exist or attempting to access files without sufficient permissions. The information this tester provides is:

- Memory leaks
- Open file descriptors
- Correct output compared with the equivalent shell command (if applicable)
- Exit codes

The tester will display all of this information in a straight forward manner and show any differences in output and exit codes.

## What are the Differences?

The mandatory and bonus testers are mostly the same with a few key differences. Obviously, the bonus tester will compile the bonus version of Pipex, here_doc functionality is tested, more than 2 commands are tested, etc. 

## How to Run the Tester

The tester is completely self contained. Simply place the tester in the root directory for your pipex and run the script (ex. "bash test.sh") and the tester will automatically compile a fresh copy of your program and begin running the tests. It will generate files with which to test (not all of which will be in the root directory) so it's recommended to let the script finish completely so it can remove these files automatically. The bonus version also works the same way with the exception of the final test (here_doc) which will ask for user input. Instructions are provided mid-run. 

> [!NOTE]
> This tester is not a definitive guide on the functionality of pipex. This is only my own personal tests. There may be edge cases that are not considered here. 