GREEN='\e[1;32m'
PURPLE='\e[1;35m'
RED='\e[1;31m'
WHITE='\e[1;37m'
RESET='\033[0m'
VALGRIND='valgrind --leak-check=full --track-fds=yes --show-leak-kinds=all '


make fclean
ls > ls_before
make bonus
make clean
ls > ls_after
diff ls_before ls_after > pname
PROGRAM=$(grep -o 'pipex[^ ]*' pname)
clear
echo -e "test\ntest\ntest\ntest\ngood\ngood\ngood\n\ntest\n" > julestestinfile
mkdir julestestdir

echo -e "${PURPLE}
Valid Input

${RESET}"
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
${VALGRIND}./${PROGRAM} julestestinfile "grep e" "wc -l" julestestoutfile
echo $? > julestestexit
< julestestinfile grep e | wc -l > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Outfile Doesn't Exist

${RESET}"
${VALGRIND}./${PROGRAM} julestestinfile "grep e" "wc -l" julestestoutfile2
echo $? > julestestexit
< julestestinfile grep e | wc -l > julestestfile
echo $? >> julestestexit
if diff julestestoutfile2 julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e  "${PURPLE}
Infile Doesn't Exist

${RESET}"
${VALGRIND}./${PROGRAM} julestestinfile2 "grep e" "wc -l" julestestoutfile
echo $? > julestestexit
< julestestinfile2 grep e | wc -l > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Command 1 Doesn't Exist

${RESET}"
${VALGRIND}./${PROGRAM} julestestinfile "a" "wc -l" julestestoutfile
echo $? > julestestexit
< julestestinfile a | wc -l > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Command 2 Doesn't Exist

${RESET}"
${VALGRIND}./${PROGRAM} julestestinfile "grep e" "a" julestestoutfile
echo $? > julestestexit
< julestestinfile grep e | a > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Neither Command Exists

${RESET}"
${VALGRIND}./${PROGRAM} julestestinfile "a" "a" julestestoutfile
echo $? > julestestexit
< julestestinfile a | a > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Multiple Commands

${RESET}"
${VALGRIND}./${PROGRAM} julestestinfile "grep e" "wc -l" "wc -w" julestestoutfile
echo $? > julestestexit
< julestestinfile grep e | wc -l | wc -w > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


bash -c "
GREEN='\e[1;32m'
PURPLE='\e[1;35m'
RED='\e[1;31m'
RESET='\033[0m'
VALGRIND='valgrind --leak-check=full --track-fds=yes --show-leak-kinds=all '
PROGRAM='./pipex'
unset PATH
/bin/echo -e '${PURPLE}
Unset Path Test

${RESET}'
/bin/echo -n > julestestoutfile
/bin/echo -n > julestestfile
/bin/echo -n > julestestexit
/bin/${VALGRIND}./${PROGRAM} julestestinfile cat cat julestestoutfile | /bin/echo $? > julestestexit
< julestestinfile cat | cat > julestestfile | /bin/echo $? >> julestestexit
if [ ! -s julestestoutfile ]; then
    /bin/echo -e '${GREEN}\nOutput Correct\n${RESET}'
else
    /bin/echo -e '${RED}\nOutput Incorrect\n${RESET}'
fi
if /bin/diff <(/bin/sed -n '1p' julestestexit) <(/bin/sed -n '2p' julestestexit); then
    /bin/echo -e '${GREEN}\nExit Code Correct\n${RESET}'
else
    /bin/echo -e '${RED}\nExit Code Incorrect\n${RESET}'
fi
/bin/echo -e '${PURPLE}
----------------------------------------
${RESET}'"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Infile Permissions Removed

${RESET}"
chmod 111 julestestinfile
${VALGRIND}./${PROGRAM} julestestinfile "grep e" "wc -l" julestestoutfile
echo $? > julestestexit
< julestestinfile grep e | wc -l > julestestfile
echo $? >> julestestexit
chmod 777 julestestinfile
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Outfile Permissions Removed

${RESET}"
chmod 111 julestestoutfile
chmod 111 julestestfile
${VALGRIND}./${PROGRAM} julestestinfile "grep e" "wc -l" julestestoutfile
echo $? > julestestexit
< julestestinfile grep e | wc -l > julestestfile
echo $? >> julestestexit
chmod 777 julestestoutfile
chmod 777 julestestfile
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -e "${PURPLE}
Relative Path

${RESET}"
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo '#include <stdio.h>

int main()
{
	printf("This\nis\na\ntest\nprogram\n");
	return (0);
}' > julestestexe.c
cc julestestexe.c -o ../julestestexe
${VALGRIND}./${PROGRAM} julestestinfile ".././julestestexe" "wc -l" julestestoutfile
echo $? > julestestexit
< julestestinfile .././julestestexe | wc -l > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -e "${PURPLE}
Absolute Path

${RESET}"
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
current_dir=$(pwd)
cc julestestexe.c -o "$current_dir/julestestdir/julestestexe"
${VALGRIND}./${PROGRAM} julestestinfile "$current_dir/julestestdir/julestestexe" "wc -l" julestestoutfile
echo $? > julestestexit
< julestestinfile $current_dir/julestestdir/julestestexe | wc -l > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -e "${PURPLE}
Script as Command

${RESET}"
echo "#!/bin/bash
echo HELLO" > script.sh
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
${VALGRIND}./${PROGRAM} julestestinfile "sh script.sh" "wc -l" julestestoutfile
echo $? > julestestexit
< julestestinfile sh script.sh | wc -l > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Insufficient Commands

${RESET}"
${VALGRIND}./${PROGRAM} julestestinfile "wc -l" julestestoutfile
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
echo -e "${GREEN}\nExit Code Not Tested\n${RESET}"
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -e "${PURPLE}
Quoted Argument

${RESET}"
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
${VALGRIND}./${PROGRAM} julestestinfile "grep 'quote this'" "wc -l" julestestoutfile
echo $? > julestestexit
< julestestinfile grep 'quote this' | wc -l > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Command 1 Empty

${RESET}"
${VALGRIND}./${PROGRAM} julestestinfile "" "wc -l" julestestoutfile
echo $? > julestestexit
< julestestinfile "" | wc -l > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Command 2 Empty

${RESET}"
${VALGRIND}./${PROGRAM} julestestinfile "grep e" "" julestestoutfile
echo $? > julestestexit
< julestestinfile grep e | "" > julestestfile
echo $? >> julestestexit
if [ ! -s julestestoutfile ]; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Command 3 Empty

${RESET}"
${VALGRIND}./${PROGRAM} julestestinfile "grep e" "wc -l" "" julestestoutfile
echo $? > julestestexit
< julestestinfile grep e | wc -l | "" > julestestfile
echo $? >> julestestexit
if [ ! -s julestestoutfile ]; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Both Commands Empty

${RESET}"
${VALGRIND}./${PROGRAM} julestestinfile "" "" julestestoutfile
echo $? > julestestexit
< julestestinfile "" | "" > julestestfile
echo $? >> julestestexit
if [ ! -s julestestoutfile ]; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
3 Commands Empty

${RESET}"
${VALGRIND}./${PROGRAM} julestestinfile "" "" "" julestestoutfile
echo $? > julestestexit
< julestestinfile "" | "" | "" > julestestfile
echo $? >> julestestexit
if [ ! -s julestestoutfile ]; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -e "${PURPLE}
All Blank Input

${RESET}"
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
${VALGRIND}./${PROGRAM} "" "" "" ""
echo $? > julestestexit
< "" "" | "" > ""
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -e "${PURPLE}
First Command is Directory

${RESET}"
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
${VALGRIND}./${PROGRAM} julestestinfile "julestestdir/" "wc -l" julestestoutfile
echo $? > julestestexit
< julestestinfile julestestdir/ | wc -l > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -e "${PURPLE}
Second Command is Directory

${RESET}"
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
${VALGRIND}./${PROGRAM} julestestinfile "grep e" "julestestdir/" julestestoutfile
echo $? > julestestexit
< julestestinfile grep e | julestestdir/ > julestestfile
echo $? >> julestestexit
if [ ! -s julestestoutfile ]; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"



echo -e "${PURPLE}
Both Commands are Directories

${RESET}"
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
${VALGRIND}./${PROGRAM} julestestinfile "julestestdir/" "julestestdir/" julestestoutfile
echo $? > julestestexit
< julestestinfile julestestdir/ | julestestdir/ > julestestfile
echo $? >> julestestexit
if [ ! -s julestestoutfile ]; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -e "${PURPLE}
3 Commands are Directories

${RESET}"
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
${VALGRIND}./${PROGRAM} julestestinfile "julestestdir/" "julestestdir/" "julestestdir/" julestestoutfile
echo $? > julestestexit
< julestestinfile julestestdir/ | julestestdir/ | julestestdir/ > julestestfile
echo $? >> julestestexit
if [ ! -s julestestoutfile ]; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -e "${PURPLE}
Infile is Directory

${RESET}"
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
${VALGRIND}./${PROGRAM} julestestdir/ "grep e" "wc -l" julestestoutfile
echo $? > julestestexit
< julestestdir/ grep e | wc -l > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -e "${PURPLE}
Outfile is Directory

${RESET}"
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
${VALGRIND}./${PROGRAM} julestestinfile "grep e" "wc -l" julestestdir/
echo $? > julestestexit
< julestestfile grep e | wc -l > julestestdir/
echo $? >> julestestexit
if [ ! -f julestestdir/ ]; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -e "${PURPLE}
Both Files are Directories

${RESET}"
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
${VALGRIND}./${PROGRAM} julestestdir/ "grep e" "wc -l" julestestdir/
echo $? > julestestexit
< julestestdir/ grep e | wc -l > julestestdir/
echo $? >> julestestexit
if [ ! -f julestestdir/ ]; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -e "${PURPLE}
Everything is a Directory

${RESET}"
echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
${VALGRIND}./${PROGRAM} julestestdir/ julestestdir/ julestestdir/ julestestdir/
echo $? > julestestexit
< julestestdir/ julestestdir/ | julestestdir/ > julestestdir/
echo $? >> julestestexit
if [ ! -f julestestdir/ ]; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Sleep Test (Same Values)
${RESET}"
while true; do
    echo -ne "${PURPLE}$(date +'%T')\r${RESET}"
    sleep 1
done &
${VALGRIND}./${PROGRAM} julestestinfile "sleep 10" "sleep 10" "sleep 10" "sleep 10" "sleep 10" "sleep 10" "sleep 10" "sleep 10" "sleep 10" julestestoutfile
kill $!
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
echo -e "${GREEN}\nExit Code Not Tested\n${RESET}"
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Sleep Test (Different Values)
${RESET}"
while true; do
    echo -ne "${PURPLE}$(date +'%T')\r${RESET}"
    sleep 1
done &
${VALGRIND}./${PROGRAM} julestestinfile "sleep 10" "sleep 5" "sleep 7" "sleep 2" julestestoutfile
kill $!
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
echo -e "${GREEN}\nExit Code Not Tested\n${RESET}"
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Combo Test
${RESET}"
${VALGRIND}./${PROGRAM} julestestdir/ "cat" "grep e" "cat/" "/usr/bin/wc" "sh script.sh" "./julestestexe" "" "a" julestestoutfile
echo $? > julestestexit
< julestestdir/ cat | grep e | cat/ | /usr/bin/wc | sh script.sh | ./julestestexe | "" | a > julestestfile
echo $? >> julestestexit
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
if diff <(sed -n '1p' julestestexit) <(sed -n '2p' julestestexit); then
    echo -e "${GREEN}\nExit Code Correct\n${RESET}"
else
    echo -e "${RED}\nExit Code Incorrect\n${RESET}"
fi
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
Insufficient Commands here_doc
${RESET}"
echo -e "${WHITE}\nTest Expects 1 'e' as result. Delim is EOF.
${RESET}"
${VALGRIND}./${PROGRAM} here_doc EOF "wc -l" julestestoutfile
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
echo -e "${GREEN}\nExit Code Not Tested\n${RESET}"
echo -e "${PURPLE}
----------------------------------------
${RESET}"


echo -n > julestestoutfile
echo -n > julestestfile
echo -n > julestestexit
echo -e "${PURPLE}
here_doc
${RESET}"
echo -e "${WHITE}\nTest Expects 1 'e' as result. Delim is EOF.
${RESET}"
${VALGRIND}./${PROGRAM} here_doc EOF "grep e" "wc -l" julestestoutfile
echo 1 > julestestfile
if diff julestestoutfile julestestfile; then
    echo -e "${GREEN}\nOutput Correct\n${RESET}"
else
    echo -e "${RED}\nOutput Incorrect\n${RESET}"
fi
echo -e "${GREEN}\nExit Code Not Tested\n${RESET}"
echo -e "${PURPLE}
----------------------------------------
${RESET}"

rm -rf julestestinfile julestestoutfile julestestoutfile2 julestestfile ../julestestexe julestestdir/julestestexe julestestexe.c script.sh julestestdir/ ls_before ls_after pname julestestexit
