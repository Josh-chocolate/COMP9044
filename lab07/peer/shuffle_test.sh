#!/bin/bash

# test output file is correct
test_correct(){
    str1=`echo "$1" | sort` 
    str2=`cat test.txt | sort`

    [ "$str1" != "$str2" ] && echo "output is wrong"
}
array_join(){
    $array=$1
    $joined_str=""
    for element in "${array[@]}"
    do
        joined_str="$joined_str\n"
    done
    echo "$joined_str"
}
# generate random file
file_sizes=5
random_str_size=13
random_file_content=()
i=1;
printf "" > test.txt
while [ $i -le $file_sizes ]
do
    # random string
    rand_str=`tr -dc A-Za-z0-9 </dev/urandom | head -c $random_str_size`
    newline="line:$i $rand_str"
    echo "$newline" >> test.txt;
    random_file_content[$i]=$newline
    i=$((i + 1))
done
echo "generating all possible output files"
echo "....."
all_possible_content=""
# generate all orders of indices
for i in `seq 1 5`;do
    for j in `seq 1 5 | sed "s/$i//"`;do
        for k in `seq 1 5 | sed "s/$j//;s/$i//"`;do
            for l in `seq 1 5 | sed "s/$j//;s/$i//;s/$k//"`;do
                for m in `seq 1 5 | sed "s/$j//;s/$i//;s/$k//;s/$l//"`;do
                    file_content="${random_file_content[$i]}\n${random_file_content[$j]}\n${random_file_content[$k]}\n${random_file_content[$l]}\n${random_file_content[$m]}\n"
                    file_hash=`printf "$file_content" | sha1sum` 
                    all_possible_content="$all_possible_content$file_hash\n"
                done
            done
        done
    done
done
printf "$all_possible_content" > all_possible_content.txt
echo "finished"
echo "testing shuffle.pl .."
while [ ! -z "$all_possible_content" ];do
    file_output=`perl shuffle.pl < test.txt` 
    test_correct "$file_output"
    echo "shuffled file:"
    echo "$file_output"
    file_output_hash=`echo "$file_output" | sha1sum`
    match=`cat all_possible_content.txt | grep "^$file_output_hash$"`
    [ ! -z "$match" ] && printf "generated file pass\n"
    sed -i "s/^$file_output_hash$//" all_possible_content.txt
    all_possible_content=`cat all_possible_content.txt`
done

echo "finshed all test, shuffle.pl pass"
rm all_possible_content.txt

