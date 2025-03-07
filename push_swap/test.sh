#!/bin/bash
GREEN='\e[1;32m'
PURPLE='\e[1;35m'
RED='\e[1;31m'
WHITE='\e[1;37m'
RESET='\033[0m'
VALGRIND='valgrind --leak-check=full --show-leak-kinds=all'


# Check if program exists and if not create

if [ ! -f "./push_swap" ]; then
	make
	make clean
fi
if [ ! -f "./push_swap" ]; then
	echo -e "${RED}Cannot create program. Exiting test...\n${RESET}"
	exit 1
fi
echo -e "----- TRACE BEGINS -----\n" >> push_swap_trace

# Do basic tests to check error cases and sorted arguments

echo -e "${PURPLE}--- ${WHITE}Basic Tests${PURPLE} ---\n${RESET}"

./push_swap > julestestout 2> /dev/null
echo -n > julestestfile
if diff julestestout julestestfile > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "No arguments did not return control\n" >> push_swap_trace
fi
./push_swap "1 2 3 4 5" > julestestout 2> /dev/null
echo -n > julestestfile
if diff julestestout julestestfile > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Arguments did not return control\n1 2 3 4 5\n" >> push_swap_trace
fi
./push_swap "-5 -4 -3 -2 -1 0 1 2 3 4 5" > julestestout 2> /dev/null
echo -n > julestestfile
if diff julestestout julestestfile > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Arguments did not return control:\n-5 -4 -3 -2 -1 0 1 2 3 4 5\n" >> push_swap_trace
fi
echo -e "Error" > julestestfile
./push_swap "numbers" 2> julestestout 1> /dev/null
if diff julestestout julestestfile > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Program did not return Error:\nnumbers\n" >> push_swap_trace
fi
./push_swap "5 -2 - 0 +2 +" 2> julestestout 1> /dev/null
if diff julestestout julestestfile > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Program did not return Error:\n5 -2 - 0 +2 +\n" >> push_swap_trace
fi
./push_swap "5 3 2 1 5 4" 2> julestestout 1> /dev/null
if diff julestestout julestestfile > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Program did not return Error:\n5 3 2 1 5 4\n" >> push_swap_trace
fi

# Check push_swap actually runs when it should

./push_swap "-5 5 -4 4 -3 3 -2 2 -1 1 0" 1> julestestout 2> /dev/null
if diff julestestout julestestfile > /dev/null; then
	echo -n "❌"
	echo -e "Program did not run:\n-5 5 -4 4 -3 3 -2 2 -1 1 0\n" >> push_swap_trace
else
	echo -n "✅"
fi
# Test push_swap with 100 randomly generated unique arguments
echo -e "${PURPLE}\n\n--- ${WHITE}Operation Count Tests${PURPLE} ---\n${RESET}"
MAX=0
TOTAL=0
RUNS=500
echo -e "${PURPLE}--- ${WHITE} Target Operations For 100 Arguments: ${PURPLE}700 ---\n${RESET}"
for i in $(seq 1 "$RUNS"); do
    ARGS=$(shuf -i 1-10000 -n 100 2> /dev/null | tr '\n' ' ')
    RESULT=$(./push_swap $ARGS | wc -l)
    if [ "$RESULT" -gt "$MAX" ]; then
        MAX=$RESULT
    fi
	if [ "$RESULT" -gt 700 ]; then
		echo -e "Operation Count Failed with these arguments:\n${ARGS}\n" >> push_swap_trace
	fi
	TOTAL=$((TOTAL + RESULT))
    COMPLETION=$((i * 100 / "$RUNS"))
    echo -ne "\r% ${PURPLE}Progress:${WHITE} $COMPLETION%${RESET}"
done
echo -ne "\r\033[K"
AVERAGE=$((TOTAL / "$RUNS"))
if [ "$AVERAGE" -gt 700 ]; then
	echo -e "${WHITE}-- Average Operations: ${RED}$AVERAGE ${WHITE}--\n${RESET}"
else
	echo -e "${WHITE}-- Average Operations: ${GREEN}$AVERAGE ${WHITE}--\n${RESET}"
fi
if [ "$MAX" -gt 700 ]; then
	echo -e "${WHITE}-- Worst Case Operations: ${RED}$MAX ${WHITE}--\n${RESET}"
else
	echo -e "${WHITE}-- Worst Case Operations: ${GREEN}$MAX ${WHITE}--\n${RESET}"
fi

# Test push_swap with 500 randomly generated unique arguments

MAX=0
TOTAL=0
RUNS=5
echo -e "${PURPLE}\n--- ${WHITE}Target Operations For 500 Arguments: ${PURPLE}5500 ---\n${RESET}"
for i in $(seq 1 "$RUNS"); do
    ARGS=$(shuf -i 1-10000 -n 500 | tr '\n' ' ')
    RESULT=$(./push_swap $ARGS 2> /dev/null | wc -l)

    if [ "$RESULT" -gt "$MAX" ]; then
        MAX=$RESULT
    fi
	if [ "$RESULT" -gt 5500 ]; then
		echo -e "Operation Count Failed with these arguments:\n${ARGS}\n" >> push_swap_trace
	fi
	TOTAL=$((TOTAL + RESULT))
    COMPLETION=$((i * 100 / "$RUNS"))
    echo -ne "\r% ${PURPLE}Progress:${WHITE} $COMPLETION%${RESET}"
done
echo -ne "\r\033[K"
AVERAGE=$((TOTAL / "$RUNS"))
if [ "$AVERAGE" -gt 5500 ]; then
	echo -e "${WHITE}-- Average Operations: ${RED}$AVERAGE ${WHITE}--\n${RESET}"
else
	echo -e "${WHITE}-- Average Operations: ${GREEN}$AVERAGE ${WHITE}--\n${RESET}"
fi
if [ "$MAX" -gt 5500 ]; then
	echo -e "${WHITE}-- Worst Case Operations: ${RED}$MAX ${WHITE}--\n${RESET}"
else
	echo -e "${WHITE}-- Worst Case Operations: ${GREEN}$MAX ${WHITE}--\n${RESET}"
fi

# Check if checker_linux exists and if not do not runs tests

echo -e "OK" > julestestfile
if [ ! -f "./checker_linux" ]; then
	echo -e "${RED}\n--- Checker not found: Cannot perform tests ---${RESET}"
else

	# Run push_swap against checker with 100 randomly generated unique arguments

	echo -e "${PURPLE}\n--- Checker 100 ---\n${RESET}"
	chmod 777 checker_linux
	for i in $(seq 1 10); do
		ARGS=$(shuf -i 1-10000 -n 100 | tr '\n' ' ');
		./push_swap $ARGS | ./checker_linux $ARGS 1> julestestout 2> /dev/null;
		if diff julestestout julestestfile > /dev/null; then
			echo -n "✅"
		else
			echo -n "❌"
			echo -e "Checker returned KO with these arguments:\n${ARGS}\n" >> push_swap_trace
		fi
	done

	# Run push_swap against checker with 500 randomly generated unique arguments

	echo -e "${PURPLE}\n\n--- Checker 500 ---\n${RESET}"
	for i in $(seq 1 10); do
		ARGS=$(shuf -i 1-10000 -n 500 | tr '\n' ' ');
		./push_swap $ARGS | ./checker_linux $ARGS 1> julestestout 2> /dev/null;
		if diff julestestout julestestfile > /dev/null; then
			echo -n "✅"
		else
			echo -n "❌"
			echo -e "Checker returned KO with these arguments:\n${ARGS}\n" >> push_swap_trace
		fi
	done
	rm julestestfile julestestout
fi

# Check valgrind for 100 arguments

echo -e "${PURPLE}\n\n--- Valgrind Check ---\n${RESET}"
echo -e "ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)" > julestestvalcheck
ARGS=$(shuf -i 1-10 -n 10 | tr '\n' ' ')
${VALGRIND} --log-file=julestestval ./push_swap $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS="0 1 2 3 4 5 6 7 8 9"
${VALGRIND} --log-file=julestestval ./push_swap $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS="-5 5 -4 4 -3 3 -2 2 -1 1 0"
${VALGRIND} --log-file=julestestval ./push_swap $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS="numbers"
${VALGRIND} --log-file=julestestval ./push_swap $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS="- 50 21 506"
${VALGRIND} --log-file=julestestval ./push_swap $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS='"5" "3" "2" "1" "4"'
${VALGRIND} --log-file=julestestval ./push_swap $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS="2147483647 -2147483648"
${VALGRIND} --log-file=julestestval ./push_swap $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS="2147483648 -2147483649"
${VALGRIND} --log-file=julestestval ./push_swap $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
rm julestestval julescheckval julestestvalcheck

# Try to compile bonus

echo -e "${PURPLE}\n\n--- ${WHITE}Attempting to compile bonus${PURPLE} ---\n${RESET}"
if [ ! -f "./checker" ]; then
	make bonus
	make clean
fi
if [ ! -f "./checker" ]; then
	echo -e "${RED}Cannot create bonus. Exiting test...\n${RESET}"
	echo -e "\n---- TRACE ENDS ----\n" >> push_swap_trace
	exit 1
fi
echo -e "${GREEN}-- ${WHITE}Success ${GREEN}--\n${RESET}"

# Perform basic tests on checker

echo -e "${PURPLE}--- ${WHITE}Basic Tests${PURPLE} ---\n${RESET}"
echo -e "OK" > julestestfile
echo -e "KO" > julestestfile2
echo -e "Error" > julestestfile3
echo -n > julestestfile4
./checker "5 3 4 2 1" <<EOF 1> julesbonusout 2> /dev/null
pb
pb
ra
sa
rra
pa
ra
ra
pa
ra
EOF
if diff julesbonusout julestestfile > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Checker failed with these arguments:\n5 3 4 2 1\nWith these commands:\npb\npb\nra\nsa\nrra\npa\nra\nra\npa\nra" >> push_swap_trace
fi
./checker "1 2 3 4 5" <<EOF 1> julesbonusout 2> /dev/null
EOF
if diff julesbonusout julestestfile > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Checker failed with these arguments:\n1 2 3 4 5\n" >> push_swap_trace
fi
./checker "1 2 3 4 5 5" 2> julesbonusout 1> /dev/null
if diff julesbonusout julestestfile3 > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Checker failed with these arguments:\n1 2 3 4 5 5\n" >> push_swap_trace
fi
./checker "1 2 3 4 5 2147483648" 2> julesbonusout 1> /dev/null
if diff julesbonusout julestestfile3 > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Checker failed with these arguments:\n1 2 3 4 5 2147483648\n" >> push_swap_trace
fi
./checker "1 2 3 4 5 q" 2> julesbonusout 1> /dev/null
if diff julesbonusout julestestfile3 > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Checker failed with these arguments:\n1 2 3 4 5 q\n" >> push_swap_trace
fi
./checker "1" <<EOF 1> julesbonusout 2> /dev/null
EOF
if diff julesbonusout julestestfile > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Checker failed with these arguments:\n1\n" >> push_swap_trace
fi

rm julesbonusout julestestfile2 julestestfile3 julestestfile4

# Run push_swap against bonus with 100 randomly generated unique arguments

echo -e "${PURPLE}\n\n--- Bonus 100 ---\n${RESET}"
for i in $(seq 1 10); do
	ARGS=$(shuf -i 1-10000 -n 100 | tr '\n' ' ');
	./push_swap $ARGS | ./checker $ARGS 1> julestestout 2> /dev/null;
	if diff julestestout julestestfile > /dev/null; then
		echo -n "✅"
	else
		echo -n "❌"
		echo -e "Checker returned KO with these arguments:\n${ARGS}\n" >> push_swap_trace
	fi
done

# Run push_swap against bonus with 500 randomly generated unique arguments

echo -e "${PURPLE}\n\n--- Bonus 500 ---\n${RESET}"
for i in $(seq 1 10); do
	ARGS=$(shuf -i 1-10000 -n 500 | tr '\n' ' ');
	./push_swap $ARGS | ./checker $ARGS 1> julestestout 2> /dev/null;
	if diff julestestout julestestfile > /dev/null; then
		echo -n "✅"
	else
		echo -n "❌"
		echo -e "Checker returned KO with these arguments:\n${ARGS}\n" >> push_swap_trace
	fi
done
rm julestestfile julestestout

# Memory leak check for bonus

echo -e "${PURPLE}\n\n--- Valgrind Check ---\n${RESET}"
echo -e "ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)" > julestestvalcheck
ARGS=$(shuf -i 1-10 -n 10 | tr '\n' ' ')
./push_swap $ARGS 2>/dev/null | ${VALGRIND} --log-file=julestestval ./checker $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS="0 1 2 3 4 5 6 7 8 9"
./push_swap $ARGS 2>/dev/null | ${VALGRIND} --log-file=julestestval ./checker $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS="-5 5 -4 4 -3 3 -2 2 -1 1 0"
./push_swap $ARGS 2>/dev/null | ${VALGRIND} --log-file=julestestval ./checker $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS="numbers"
./push_swap $ARGS 2>/dev/null | ${VALGRIND} --log-file=julestestval ./checker $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS="- 50 21 506"
./push_swap $ARGS 2>/dev/null | ${VALGRIND} --log-file=julestestval ./checker $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS='"5" "3" "2" "1" "4"'
./push_swap $ARGS 2>/dev/null | ${VALGRIND} --log-file=julestestval ./checker $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS="2147483647 -2147483648"
./push_swap $ARGS 2>/dev/null | ${VALGRIND} --log-file=julestestval ./checker $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
ARGS="2147483648 -2147483649"
./push_swap $ARGS 2>/dev/null | ${VALGRIND} --log-file=julestestval ./checker $ARGS > /dev/null 2>&1
grep "ERROR SUMMARY:" julestestval  | sed 's/==[0-9]\+== //g' > julescheckval
if diff julestestvalcheck julescheckval > /dev/null; then
	echo -n "✅"
else
	echo -n "❌"
	echo -e "Memory leak with these arguments:\n${ARGS}\n" >> push_swap_trace
fi
echo -e "\n"
rm julestestval julescheckval julestestvalcheck

echo -e "\n---- TRACE ENDS ----\n" >> push_swap_trace
